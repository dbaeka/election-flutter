import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/controllers/my-functions.dart';
import 'package:flutter_auth/modals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class AdminEditResult extends StatefulWidget {
  //final Map payload;
  final String id;

  // receive data from the FirstScreen as a parameter
  //AdminEditResult({Key key, @required this.payload}) : super(key: key);

  AdminEditResult({Key key, @required this.id}) : super(key: key);

  @override
  //AdminEditResultState createState() => AdminEditResultState(payload: payload);
  AdminEditResultState createState() => AdminEditResultState(id: id);
}

class AdminEditResultState extends State<AdminEditResult> {
  //final Map payload;
  final String id;

  //TextEditingController _msgController = new TextEditingController();

  // receive data from the FirstScreen as a parameter
  AdminEditResultState({Key key, @required this.id}) : super();

  GlobalKey<ScaffoldState> scaffoldKey;

  SizedBox divider = SizedBox(height: 20);

  TextEditingController _npp = TextEditingController();
  TextEditingController _ndc = TextEditingController();
  TextEditingController _gum = TextEditingController();
  TextEditingController _cpp = TextEditingController();
  TextEditingController _gfp = TextEditingController();
  TextEditingController _gcpp = TextEditingController();
  TextEditingController _apc = TextEditingController();
  TextEditingController _lpg = TextEditingController();
  TextEditingController _pnc = TextEditingController();
  TextEditingController _ppp = TextEditingController();
  TextEditingController _ndp = TextEditingController();
  TextEditingController _indp = TextEditingController();

  Map payload;
  Map header;

  @override
  void initState() {
    super.initState();

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
    String feedback = await MyFunctions.getSingleResult(id);

    //print(feedback);

    //return;

    Map loadedData = jsonDecode(feedback);

    setState(() {
      payload = loadedData["data"]["attributes"]["records"];
      payload["remark"] = loadedData["data"]["attributes"]["remark"];
      payload["stationId"] = loadedData["data"]["attributes"]["station_code"];
      payload["recent_image"]=loadedData["data"]["attributes"]["recent_image"];

      /*print("New Pyalooad " + payload.toString());
      return;*/

      _npp.text = payload["1"].toString();
      _ndc.text = payload["2"].toString();
      _gum.text = payload["3"].toString();
      _cpp.text = payload["4"].toString();
      _gfp.text = payload["5"].toString();
      _gcpp.text = payload["6"].toString();
      _apc.text = payload["7"].toString();
      _lpg.text = payload["8"].toString();
      _pnc.text = payload["9"].toString();
      _ppp.text = payload["10"].toString();
      _ndp.text = payload["11"].toString();
      _indp.text = payload["12"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('Uploaded Result Detail')),
        body: Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: Builder(
              builder: (context) => SingleChildScrollView(
                  child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: payload == null
                    ? Center(
                        child: Container(
                            margin: EdgeInsets.all(50),
                            child: CircularProgressIndicator()))
                    : Container(
                        margin: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(children: <Widget>[
                          /*Container(
                            margin: EdgeInsets.all(30),
                            child: Center(
                              child: Text("${payload["time"]}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87)),
                            ),
                          ),
                          Divider(),*/
                          Card(
                            child: Container(
                              margin: EdgeInsets.all(30),
                              child: Center(
                                child:
                                    Text("STATION ID:  " + payload["stationId"],
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _npp,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _ndc,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _gum,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _cpp,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _gfp,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _gcpp,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _apc,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _lpg,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _pnc,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _ppp,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                child: TextField(
                                  style: TextStyle(fontSize: 40),
                                  controller: _ndp,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                                  child: TextField(
                                style: TextStyle(fontSize: 40),
                                controller: _indp,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              )),
                            ),
                          ]),
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
                                    Text(payload["remark"],
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
                                    child: Container(
                                        /*alignment: Alignment.bottomCenter,
                                    child: Image.network("${payload["image_url"]}",
                                     headers: header)*/
                                        ),
                                  ),
                                ),
                          SizedBox(height: size.height * 0.05),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.all(10),
                                child: RoundedButton(
                                    text: "SAVE CHANGES",
                                    press: () async {
                                      Map post = {
                                        "data": {
                                          "id": payload["id"],
                                          "type": "results",
                                          "attributes": {
                                            "records": {
                                              "1": _npp.text,
                                              "2": _ndc.text,
                                              "3": _gum.text,
                                              "4": _cpp.text,
                                              "5": _gfp.text,
                                              "6": _gcpp.text,
                                              "7": _apc.text,
                                              "8": _lpg.text,
                                              "9": _pnc.text,
                                              "10": _ppp.text,
                                              "11": _ndp.text,
                                              "12": _indp.text,
                                            }
                                          }
                                        }
                                      };

                                      //send the data to update
                                      //saveEditedResults
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          "edited-result", jsonEncode(post));

                                      String feedbackMsg = "";
                                      try {
                                        showAlertDialog(context, "Saving...");
                                        feedbackMsg = await MyFunctions
                                                .saveEditedResults(post)
                                            .timeout(
                                                const Duration(seconds: 15));

                                        Navigator.pop(context);

                                        if (feedbackMsg.trim() == "200") {
                                          SweetAlert.show(context,
                                              title: "Edited",
                                              subtitle:
                                                  "Edit succesful. Go Back to Dashboard and reload",
                                              style: SweetAlertStyle.success);
                                        } else {
                                          SweetAlert.show(context,
                                              title: "Failed",
                                              subtitle: "Edit failed",
                                              style: SweetAlertStyle.error);
                                        }
                                      } catch (e) {
                                        toast("Result failed to save");
                                      }
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
