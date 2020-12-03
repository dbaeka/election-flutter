import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/controllers/my-functions.dart';
import 'package:flutter_auth/modals.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:flutter_auth/Screens/EngineEditResult.dart';

class AdminViewDetails extends StatefulWidget {
  final String id;

  // receive data from the FirstScreen as a parameter
  AdminViewDetails({Key key, @required this.id}) : super(key: key);

  @override
  AdminViewDetailsState createState() => AdminViewDetailsState(id: id);
}

class AdminViewDetailsState extends State<AdminViewDetails> {
  final String id;

  // receive data from the FirstScreen as a parameter
  AdminViewDetailsState({Key key, @required this.id}) : super();

  GlobalKey<ScaffoldState> scaffoldKey;

  SizedBox divider = SizedBox(height: 20);

  Map payload;
  Map header;
  //Map approved;

  @override
  void initState() {
    super.initState();

    //print(id);
    //return;
    _initializeTxtValues();
    _loadNetImage();
  }

  _loadNetImage() async {
    String token = await MyFunctions.getToken();

    Map<String, String> rheader = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    };

    setState(() {
      header = rheader;
    });
  }

  _initializeTxtValues() async {
    //print(id);
    String feedback = await MyFunctions.getSingleResult(id);

    print(feedback);
    //return;

    Map loadedData = jsonDecode(feedback);

    //print(loadedData["data"]["recent_result"]);

    setState(() {
      payload = loadedData["data"]["attributes"]["records"];
      payload["remark"] = loadedData["data"]["attributes"]["remark"];
      payload["stationId"] = loadedData["data"]["attributes"]["station_code"];
      payload["recent_image"] =
          loadedData["data"]["attributes"]["recent_image"];
      payload["recent_result"] = id;
      payload["is_approved"] = loadedData["data"]["attributes"]["is_approved"];
    });

    print(payload);
  }

  _acceptReject(bool decision) async {
    Map post = {
      "data": {
        "id": payload["recent_result"],
        "type": "results",
        "attributes": {"is_approved": decision}
      }
    };
    //print(payload);
    showAlertDialog(context, decision ? "Approving...." : "Rejecting...");
    String feedback = await MyFunctions.acceptReject(post);

    Navigator.pop(context);

    if (feedback == "200") {
      SweetAlert.show(
        context,
        title: decision ? "Approved" : "Rejected",
        subtitle: decision ? "Result approved" : "Result Rejected",
        style: SweetAlertStyle.success,
      );
      return true;
      //Navigator.pop(context);
    } else {
      SweetAlert.show(context,
          title: "Failed",
          subtitle: "Action Failed",
          style: SweetAlertStyle.error);

      return false;
      //close the main page too
      // Navigator.pop(context);
    }
    //print(feedback);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('View Result Detail')),
        body: Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: Builder(
              builder: (context) => SingleChildScrollView(
                  child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: (payload == null)
                    ? Center(
                        child: Container(
                            margin: EdgeInsets.all(30),
                            child: CircularProgressIndicator()))
                    : Container(
                        margin: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(30),
                            child: Center(
                              child: Text("Check before approval",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87)),
                            ),
                          ),
                          Card(
                            child: Container(
                              margin: EdgeInsets.all(30),
                              child: Center(
                                child: Text(
                                    "STATION ID:  " +
                                        payload["stationId"].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900],
                                      fontSize: 14,
                                    )),
                              ),
                            ),
                          ),
                          Divider(),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("NPP",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["1"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("NDC",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["2"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("GUM",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["3"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("CPP",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["4"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("GFP",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["5"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("GCPP",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["6"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("APC",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["7"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("LPG",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["8"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("PNC",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["9"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("PPP",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["10"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("NDP",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["11"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("INDP",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  payload["12"].toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(height: size.height * 0.05),
                          SizedBox(height: size.height * 0.05),
                          Card(
                            child: Container(
                              margin: EdgeInsets.all(30),
                              child: Center(
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              "STATION REMARK OR COMMENT",
                                            ))),
                                    Text(payload["remark"].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[900],
                                          fontSize: 14,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
                          payload["recent_image"].toString() == "null" ||
                                  header == null
                              ? Container()
                              : Card(
                                  child: Container(
                                    height: size.height * 0.90,
                                    width: size.width * 0.90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[200],
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                "${payload["recent_image"]}",
                                                headers: header))),
                                    child: Container(),
                                  ),
                                ),
                          /* Card(
                        child: Container(
                            height: size.height * 0.90,
                            width: size.width * 0.90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Image.network(payload["recent_image"].toString(),headers: header,
                              fit: BoxFit.contain,
                            ) //AssetImage('assets/images/ec-pinksheet.jpg'),
                            ),
                      ),*/
                          SizedBox(height: size.height * 0.05),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.all(10),
                                child: RoundedButton(
                                    color: Colors.red[500],
                                    text: "REJECT",
                                    press: () {
                                      showAlertDialog(BuildContext context) {
                                        // set up the buttons
                                        Widget cancelButton = FlatButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                        Widget continueButton = FlatButton(
                                          child: Text(
                                            "Continue",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _acceptReject(false);
                                          },
                                        );

                                        // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                          title: Text("AlertDialog"),
                                          content: Text(
                                            "Are you sure you want to REJECT this result?",
                                            style: TextStyle(
                                                color: Colors.red[700]),
                                          ),
                                          actions: [
                                            cancelButton,
                                            continueButton,
                                          ],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      }

                                      showAlertDialog(context);
                                      //Navigator.pop(context);
                                    }),
                              )),
                              if (!payload["is_approved"])
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: RoundedButton(
                                            color: Colors.green[600],
                                            text: "APPROVE",
                                            press: () {
                                              //print("Approve");
                                              showAlertDialog(
                                                  BuildContext context) {
                                                // set up the buttons
                                                Widget cancelButton =
                                                    FlatButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                );
                                                Widget continueButton =
                                                    FlatButton(
                                                  child: Text("Continue"),
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    _acceptReject(true);
                                                  },
                                                );

                                                // set up the AlertDialog
                                                AlertDialog alert = AlertDialog(
                                                  title: Text("AlertDialog"),
                                                  content: Text(
                                                      "Are you sure you want to approve this result?"),
                                                  actions: [
                                                    cancelButton,
                                                    continueButton,
                                                  ],
                                                );

                                                // show the dialog
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return alert;
                                                  },
                                                );
                                              }

                                              showAlertDialog(context);
                                            }))),
                            ],
                          ),
                          SizedBox(height: size.height * 0.05),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.all(10),
                                child: RoundedButton(
                                    text: "EDIT",
                                    color: Colors.yellow[800],
                                    press: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return EngineEditResult(id: id);
                                          },
                                        ),
                                      );
                                    }),
                              )),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.all(10),
                                child: RoundedButton(
                                    text: "CLOSE DIALOG",
                                    press: () async {
                                      Navigator.pop(context);
                                    }),
                              )),
                            ],
                          ),
                          SizedBox(height: 300),
                        ])),
              )),
            )));
  }
}
