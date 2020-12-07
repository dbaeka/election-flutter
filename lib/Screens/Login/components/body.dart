import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/SingleResultDetails.dart';
import 'package:flutter_auth/modals.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/controllers/my-functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:intl/intl.dart';
import 'package:flutter_auth/Screens/TVRoomScreen.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging _fcm = FirebaseMessaging();

String username = "";
String password = "";
String fcmToken = "";
String screenDecider;

class Body extends StatefulWidget {
  // receive data from the FirstScreen as a parameter
  Body({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Body> {
/*class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);*/

/*there are for Engine Room Screen*/
  String id;
  String iniData;
  Map allStations;
  Map allApproved;
  Map allPendings;
  Map allResults;
  Map allNew;
  Map allMedia;

/*engine room variables end here*/

  Map finalResult;

  @override
  void initState() {
    super.initState();

    fcmNotification();
  }

  void fcmNotification() async {
    _fcm.getToken().then((token) {
      //print(token);

      setState(() {
        fcmToken = token;
      });

      //saveFcmtoken(token);
    });

    _fcm.requestNotificationPermissions();
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      //print("Message on Message: $message");

      //load new result from polling stations
      if (screenDecider == "engine") _loadAllNew();

      if (screenDecider == "display") _finalResult();

      if (screenDecider != "polling") toast("New result in");
    }, onResume: (Map<String, dynamic> message) async {
      //print("Message on Resume: $message");

      //load new result from polling stations
      if (screenDecider == "engine") _loadAllNew();

      if (screenDecider == "display") _finalResult();

      if (screenDecider != "polling") toast("New result in");
    }, onLaunch: (Map<String, dynamic> message) async {
      //print("Message on Launch: $message");
      //load new result from polling stations
      if (screenDecider == "engine") _loadAllNew();

      if (screenDecider == "display") _finalResult();

      if (screenDecider != "polling") toast("New result in");
    });
  }

  _finalResult() async {
    String feedback = await MyFunctions.getElectionResult();

    setState(() {
      finalResult = jsonDecode(feedback);
      //print(finalResult);
    });
  }

  void _loadAllNew() async {
    String feedback = await MyFunctions.getAllNew();

    //print(feedback);

    if (feedback.contains("Invalid Argument Exception")) {
      setState(() {
        allNew = jsonDecode('{"data":[]}');
      });

      return;
    }

    setState(() {
      allNew = jsonDecode(feedback);
      //print("Function laoded" + allNew["data"].length);
    });
  }

  void _loadAllApproved() async {
    String feedback = await MyFunctions.getAllApproved();

    //print(feedback);

    setState(() {
      allApproved = jsonDecode(feedback);
    });
  }

  void _loadAllMedia() async {
    String feedback = await MyFunctions.getAllMedia();
    //toast("Hello");
    //print(feedback);
    setState(() {
      allMedia = jsonDecode(feedback);
      //print(allMedia[0]["links"]);
    });
  }

  void _loadPendings() async {
    String data = await MyFunctions.getPendings();

    setState(() {
      allPendings = jsonDecode(data);
    });
  }

  _engineViewDetailPage(data) {
    //print(data);
    //return;
    //return;
    String id = data["id"].toString();
    //print(id);
    //return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AdminViewDetails(
              id: id //allStations["data"][i]["attributes"]["name"]
              );
        },
      ),
    );
  }

  Map searchedData;
  void _searchResultField(String text) async {
    toast("Searching " + text + "...");

    String data = await MyFunctions.searchResult(text);

    //print(data);

    setState(() {
      searchedData = jsonDecode(data);
    });
  }

  TextEditingController _searchResult = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final formatter = new NumberFormat("#,###,###");
    //new Text(formatter.format(1234)), // formatted number will be: 1,234
    return (screenDecider == "polling" || screenDecider == null)
        ? Background(
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(30),
                  child: Text(
                    "WELCOME TO 2020 ELECTION",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue[400]),
                  ),
                ),
                Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Phone Number",
                  keyboard: TextInputType.number,
                  onChanged: (value) {
                    username = value;
                  },
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    password = value;
                  },
                ),
                RoundedButton(
                  text: "LOGIN",
                  press: () async {
                    //toast(username + " " + password);
                    try {
                      if (username == "" || password == "") {
                        toast("Enter login credentials");
                        return;
                      }
                      //print(password);

                      Map post = {
                        "phone": username,
                        "password": password,
                        "fcm_token": fcmToken
                      };

                      //print(post);

                      showAlertDialog(context, "Authenticating...");

                      String feedbackMsg = "";

                      feedbackMsg = await MyFunctions.loggIn(post);

                      //print(feedbackMsg);

                      Navigator.pop(context);

                      if (feedbackMsg == null || feedbackMsg == "") {
                        toast("User data not found");
                        return;
                      }

                      print(feedbackMsg);

                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("login", feedbackMsg);

                      Map data;
                      data = jsonDecode(feedbackMsg);
                      String role = data["role"];

                      setState(() {
                        screenDecider = role;
                      });

                      if (role == "") {
                        toast("Network connection failed");
                        return;
                      }

                      if (role == "polling")
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DashboardScreen();
                            },
                          ),
                        );

                      if (role == "engine") {
                        _loadAllNew();
                      }

                      if (role == "display") {
                        _finalResult();
                      }
                    } catch (e) {
                      toast("Login failed");
                      print(e.toString());
                    }
                  },
                ),
                SizedBox(height: size.height * 0.03),
              ],
            )),
          )
        : (screenDecider == "display")
            ? Container(
                child: Container(
                    color: Colors.black54,
                    child: (finalResult == null)
                        ? Center(
                            child:
                                Container(child: CircularProgressIndicator()))
                        : TVRoomScreen(
                            data: finalResult,
                          )))
            : (screenDecider == "engine")
                ? Container(
                    child: DefaultTabController(
                      length: 5,
                      child: Scaffold(
                        appBar: AppBar(
                          bottom: TabBar(
                              tabs: [
                                Tab(
                                    icon: Icon(Icons.record_voice_over),
                                    text: 'NEW'),
                                Tab(
                                    icon: Icon(Icons.pending_actions),
                                    text: 'APPROVED'),
                                Tab(
                                    icon: Icon(Icons.missed_video_call),
                                    text: 'MEDIA'),
                                Tab(
                                    icon: Icon(Icons.pending_actions),
                                    text: 'PENDING'),
                                Tab(icon: Icon(Icons.search), text: 'SEARCH'),
                              ],
                              onTap: (index) async {
                                try {
                                  if (index == 0) {
                                    setState(() {
                                      allNew = null;
                                    });

                                    _loadAllNew();
                                  }

                                  if (index == 1) {
                                    setState(() {
                                      allApproved = null;
                                    });

                                    _loadAllApproved();
                                  }

                                  if (index == 2) {
                                    setState(() {
                                      allMedia = null;
                                    });

                                    _loadAllMedia();
                                  }

                                  if (index == 3) {
                                    setState(() {
                                      allPendings = null;
                                    });
                                    _loadPendings();
                                  }
                                  //toast(index.toString());
                                } catch (e) {}
                              }),
                          title: Row(
                            children: [
                              Expanded(child: Text('Presidential Engine Room')),
                              FlatButton(
                                child: Text("LogOut",
                                    style: TextStyle(color: Colors.white60)),
                                onPressed: () {
                                  setState(() {
                                    screenDecider = null;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            (allNew == null)
                                ? Center(child: CircularProgressIndicator())
                                : Container(
                                    child: (allNew["data"].length < 1)
                                        ? Container(
                                            child: Center(
                                                child: Text(
                                                    "No new result available")))
                                        : ListView(
                                            children: [
                                              for (var i = 0;
                                                  i < allNew["data"].length;
                                                  i++)
                                                GestureDetector(
                                                  onTap: () {
                                                    _engineViewDetailPage(
                                                        allNew["data"][i]);
                                                  },
                                                  child: ListTile(
                                                    leading: Text(allNew["data"]
                                                                    [i]
                                                                ["attributes"]
                                                            ["station_code"]
                                                        .toString()),
                                                    title: Text(allNew["data"]
                                                                    [i]
                                                                ["attributes"]
                                                            ["station_name"]
                                                        .toString()),
                                                    subtitle: Text(
                                                        "NPP:" +
                                                            allNew["data"][i]
                                                                            ["attributes"]
                                                                        ["records"]
                                                                    ["1"]
                                                                .toString() +
                                                            ",NDC: " +
                                                            allNew["data"][i]
                                                                            ["attributes"]
                                                                        ["records"]
                                                                    ["2"]
                                                                .toString() +
                                                            ", Others: " +
                                                            allNew["data"][i]
                                                                            ["attributes"]
                                                                        ["records"]
                                                                    ["3"]
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12)),
                                                    trailing: Text("view",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[500])),
                                                  ),
                                                ),
                                            ],
                                          )),
                            Container(
                                child: (allApproved == null)
                                    ? Container(
                                        margin: EdgeInsets.all(30),
                                        child: Center(
                                            child: CircularProgressIndicator()))
                                    : Container(
                                        child: (allApproved["data"].length < 1)
                                            ? Container(
                                                child: Center(
                                                    child: Text(
                                                        "No result approved")))
                                            : ListView(
                                                children: [
                                                  for (var i = 0;
                                                      i <
                                                          allApproved["data"]
                                                              .length;
                                                      i++)
                                                    GestureDetector(
                                                      onTap: () {
                                                        _engineViewDetailPage(
                                                            allApproved["data"]
                                                                [i]);
                                                      },
                                                      child: ListTile(
                                                        leading: Text(allApproved[
                                                                        "data"][i]
                                                                    [
                                                                    "attributes"]
                                                                ["station_code"]
                                                            .toString()),
                                                        title: Text(allApproved[
                                                                        "data"][i]
                                                                    [
                                                                    "attributes"]
                                                                ["station_name"]
                                                            .toString()),
                                                        subtitle: Text(
                                                            "NPP:" +
                                                                allApproved["data"][i]["attributes"]
                                                                            ["records"]
                                                                        ["1"]
                                                                    .toString() +
                                                                ",NDC: " +
                                                                allApproved["data"][i]
                                                                            ["attributes"]["records"]
                                                                        ["2"]
                                                                    .toString() +
                                                                ", Others: " +
                                                                allApproved["data"][i]
                                                                            [
                                                                            "attributes"]["records"]
                                                                        ["3"]
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        trailing: Text("view",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey[
                                                                        500])),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                      )),
                            Container(
                                child: (allMedia == null)
                                    ? Container(
                                        margin: EdgeInsets.all(30),
                                        child: Center(
                                            child: CircularProgressIndicator()))
                                    : Container(
                                        child: (allMedia["data"].length < 1)
                                            ? Container(
                                                child: Center(
                                                    child: Text(
                                                        "No result pushed to media")))
                                            : ListView(
                                                children: [
                                                  for (var i = 0;
                                                      i <
                                                          allMedia["data"]
                                                              .length;
                                                      i++)
                                                    GestureDetector(
                                                      onTap: () {
                                                        _engineViewDetailPage(
                                                            allMedia["data"]
                                                                [i]);
                                                      },
                                                      child: ListTile(
                                                        leading: Text(allMedia[
                                                                        "data"][i]
                                                                    [
                                                                    "attributes"]
                                                                ["station_code"]
                                                            .toString()),
                                                        title: Text(allMedia[
                                                                        "data"][i]
                                                                    [
                                                                    "attributes"]
                                                                ["station_name"]
                                                            .toString()),
                                                        subtitle: Text(
                                                            "NPP:" +
                                                                allMedia["data"][i]["attributes"]
                                                                            ["records"]
                                                                        ["1"]
                                                                    .toString() +
                                                                ",NDC: " +
                                                                allMedia["data"][i]
                                                                            ["attributes"]["records"]
                                                                        ["2"]
                                                                    .toString() +
                                                                ", Others: " +
                                                                allMedia["data"][i]
                                                                            [
                                                                            "attributes"]["records"]
                                                                        ["3"]
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        trailing: Text("view",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey[
                                                                        500])),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                      )),
                            Container(
                                child: (allPendings == null)
                                    ? Container(
                                        margin: EdgeInsets.all(30),
                                        child: Center(
                                            child: CircularProgressIndicator()))
                                    : ListView(
                                        children: [
                                          for (var i = 0;
                                              i < allPendings["data"].length;
                                              i++)
                                            ListTile(
                                              leading: Text(allPendings["data"]
                                                  [i]["attributes"]["code"]),
                                              title: Text(allPendings["data"][i]
                                                  ["attributes"]["name"]),
                                            )
                                        ],
                                      )),
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _searchResult,
                                    textInputAction: TextInputAction.search,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText:
                                          "Search by Polling Station Code",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.search, size: 45),
                                        onPressed: () {
                                          setState(() {
                                            searchedData = null;
                                          });
                                          _searchResultField(
                                              _searchResult.text);
                                        },
                                      ),
                                    ),
                                  ),

                                  if(searchedData != null)
                                  if(searchedData["data"].length < 1)
                                    Container(
                                      child: Center(child: Text("No data found for the searched code"))
                                    ),

                                  if(searchedData != null)
                                    for (var i = 0;i <searchedData["data"].length;i++)
                                      GestureDetector(
                                        onTap: () {
                                          _engineViewDetailPage(
                                              searchedData[
                                                  "data"][i]);
                                        },
                                        child: Container(
                                          child: ListTile(
                                            leading: Text(searchedData[
                                                            "data"][i]
                                                        [
                                                        "attributes"]
                                                    [
                                                    "station_code"]
                                                .toString()),
                                            title: Text(searchedData[
                                                            "data"][i]
                                                        [
                                                        "attributes"]
                                                    [
                                                    "station_name"]
                                                .toString()),
                                            subtitle: Text(
                                                "NPP:" +
                                                    searchedData["data"][i]["attributes"]["records"][
                                                            "1"]
                                                        .toString() +
                                                    ",NDC: " +
                                                    searchedData["data"][i]["attributes"]["records"][
                                                            "2"]
                                                        .toString() +
                                                    ", Others: " +
                                                    searchedData["data"][i]["attributes"]["records"][
                                                            "3"]
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                        12)),
                                            trailing: Text(
                                                "view",
                                                style: TextStyle(
                                                    color: Colors
                                                            .grey[
                                                        500])),
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container();
  }
}
