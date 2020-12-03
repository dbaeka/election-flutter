import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/SingleResultDetails.dart';
import 'package:flutter_auth/Screens/TVRoomScreen.dart';
import 'package:flutter_auth/modals.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth/controllers/my-functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:intl/intl.dart';

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

/*engine room variables end here*/

  Map finalResult;

  @override
  void initState() {
    super.initState();

    fcmNotification();
  }

  void fcmNotification() async {
    _fcm.getToken().then((token) {
      print(token);

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

      toast("New result in");
    }, onResume: (Map<String, dynamic> message) async {
      //print("Message on Resume: $message");

      //load new result from polling stations
      if (screenDecider == "engine") _loadAllNew();

      if (screenDecider == "display") _finalResult();

      toast("New result in");
    }, onLaunch: (Map<String, dynamic> message) async {
      //print("Message on Launch: $message");
      //load new result from polling stations
      if (screenDecider == "engine") _loadAllNew();

      if (screenDecider == "display") _finalResult();

      toast("New result in");
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

    setState(() {
      allNew = jsonDecode(feedback);
      //print("Function laoded" + allNew["data"].length);
    });
  }

  void _loadAllApproved() async {
    //String results = await MyFunctions.getAllResults();
    String feedback = await MyFunctions.getAllApproved();

    //print(feedback);

    setState(() {
      allApproved = jsonDecode(feedback);
    });
  }

  void _loadPendings() async {
    String data = await MyFunctions.getPendings();

    setState(() {
      allPendings = jsonDecode(data);
    });
  }

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
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
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

                      Navigator.pop(context);

                      if (feedbackMsg == null || feedbackMsg == "") {
                        toast("User data not found");
                        return;
                      }

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

                      if (role == "engine") //administrator login
                      {
                        _loadAllNew();
                        /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EngineScreen();
                                },
                              ),
                            );*/
                      }

                      if (role == "display") //administrator login
                      {
                        _finalResult();
                      }
                    } catch (e) {
                      toast("Login failed");
                      print(e.toString());
                      //Navigator.pop(context);
                      // return;
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
                        child: Container(child: CircularProgressIndicator()))
                    : TVRoomScreen(data: finalResult,)
              ))
            : (screenDecider == "engine")
                ? Container(
                    child: DefaultTabController(
                      length: 3,
                      child: Scaffold(
                        appBar: AppBar(
                          bottom: TabBar(
                              tabs: [
                                Tab(
                                    icon: Icon(Icons.person_outlined),
                                    text: 'NEW'),
                                Tab(
                                    icon: Icon(Icons.pending_actions),
                                    text: 'APPROVED'),
                                Tab(
                                    icon: Icon(Icons.pending_actions),
                                    text: 'PENDING'),
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
                                      //allPendings = null;
                                    });
                                    _loadPendings();
                                  }
                                  //toast(index.toString());
                                } catch (e) {}
                              }),
                          title: Text('Engine Room'),
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
                                                    String id = allNew["data"]
                                                                    [i]
                                                                ["attributes"]
                                                            ["recent_result"]
                                                        .toString();
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
                                                  },
                                                  child: ListTile(
                                                    leading: Text(allNew["data"]
                                                            [i]["attributes"]
                                                        ["code"]),
                                                    title: Text(allNew["data"]
                                                            [i]["attributes"]
                                                        ["name"]),
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
                                            ? Container()
                                            : ListView(
                                                children: [
                                                  for (var i = 0;
                                                      i <
                                                          allApproved["data"]
                                                              .length;
                                                      i++)
                                                    GestureDetector(
                                                      onTap: () {
                                                        //print("Hello");

                                                        String id = allApproved[
                                                                        "data"][i]
                                                                    [
                                                                    "attributes"]
                                                                [
                                                                "recent_result"]
                                                            .toString();
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
                                                      },
                                                      child: ListTile(
                                                        leading: Text(
                                                            allApproved["data"]
                                                                        [i][
                                                                    "attributes"]
                                                                ["code"]),
                                                        title: Text(allApproved[
                                                                    "data"][i]
                                                                ["attributes"]
                                                            ["name"]),
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
                          ],
                        ),
                      ),
                    ),
                  )
                : Container();
  }
}
