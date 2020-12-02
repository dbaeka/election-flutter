import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ViewUploadedResult.dart';
import 'package:flutter_auth/controllers/my-functions.dart';

class UploadHistory extends StatefulWidget {
  // receive data from the FirstScreen as a parameter
  UploadHistory({Key key}) : super();

  @override
  UploadHistoryState createState() => UploadHistoryState();
}

class UploadHistoryState extends State<UploadHistory> {
  // receive data from the FirstScreen as a parameter
  UploadHistoryState({Key key}) : super();

  GlobalKey<ScaffoldState> scaffoldKey;

  SizedBox divider = SizedBox(height: 20);

  List iniData;

  bool loading = true;

  @override
  void initState() {
    super.initState();

    _loadHistory();
  }

  _loadHistory() async {
    String data = await MyFunctions.getUploadHistory();

    List feedback = jsonDecode(data)["data"];

    print(feedback);

    setState(() {
      iniData = feedback;
      loading = false;
      //print(iniData);
    });
  }

  _singleItem(Map data) {
    Map payload = data["attributes"]["records"];
    payload["time"] = data["attributes"]["updated_at"]
        .toString()
        .substring(0, 16)
        .replaceAll("T", " @ ");

    payload["image_url"] = data["attributes"]["recent_image"];
    payload["id"] = data["id"];
     //print(payload["image_url"]);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ViewUploadResult(payload: payload);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('Upload History')),
      body: loading == false
          ? Container(
              margin: EdgeInsets.all(10),
              color: Colors.white,
              child: Builder(
                builder: (context) => SingleChildScrollView(
                    child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Column(children: <Widget>[
                        if (iniData == null)
                          Center(child: Text("No entries made")),
                        if (iniData != null)
                          for (var i = 0; i < iniData.length; i++)
                            InkWell(
                              onTap: () {
                                 _singleItem(iniData[i]);
                               
                              },
                              child: ListTile(
                                leading: (iniData[i]["attributes"]["is_approved"].toString() == "true") 
                                ? Icon(Icons.check_box, color: Colors.green,)
                                : Icon(Icons.pending_actions,color: Colors.yellow[300],),
                                title: Text(iniData[i]["attributes"]
                                        ["updated_at"]
                                    .toString()
                                    .substring(0, 16)
                                    .replaceAll("T", " @ ")),
                                trailing: FlatButton(
                                  onPressed: () {
                                    _singleItem(iniData[i]);
                                  },
                                  child: Text(
                                    "view",
                                    style: TextStyle(color: Colors.blue[400]),
                                  ),
                                ),
                              ),
                            ),
                        SizedBox(height: 300),
                      ])),
                )),
              ))
          : Center(child: CircularProgressIndicator()),
    );
  }
}
