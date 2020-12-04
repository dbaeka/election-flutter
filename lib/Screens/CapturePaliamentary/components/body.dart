import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ParliamentaryPreview.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_plain_field.dart';
import 'package:flutter_auth/controllers/my-functions.dart';
import 'package:flutter_auth/modals.dart';

class Body extends StatefulWidget {
  // receive data from the FirstScreen as a parameter
  Body({Key key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  Map payload = {};
  Map result = {};
  String resultString;
  List candidates;

  @override
  void initState() {
    super.initState();

    _parliamentaryCandidates();
  }

  @override
  void dispose() {
    //_nameController.dispose();
    super.dispose();
  }

  _parliamentaryCandidates() async {
    String data = await MyFunctions.parliamentaryCandidates();
    setState(() {
      candidates = jsonDecode(data)["data"];
    });
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.all(10),
        color: Colors.white,
        child: Builder(
          builder: (context) => SingleChildScrollView(
              child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: (candidates == null)
                ? Center(
                    child: Container(
                        margin: EdgeInsets.all(50),
                        child: CircularProgressIndicator()),
                  )
                : Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(30),
                            child: Center(
                              child: Text("ENSURE ACCURACY",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900],
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                          Divider(),
                          Card(
                            child: Container(
                              margin: EdgeInsets.all(30),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("POLLING STATION CODE",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[400],
                                          fontSize: 20,
                                        )),
                                    Container(
                                      child: TextField(
                                        onChanged: (value) {
                                          payload["station_code"] = value;
                                        },
                                        autofocus: true,
                                        style: TextStyle(fontSize: 40),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          for (var i = 0; i < candidates.length; i++)
                            ListTile(
                              title: Text(
                                  candidates[i]["attributes"]["name"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 30,
                                  )),
                              subtitle: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        candidates[i]["attributes"]
                                                ["party_short_name"]
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                  ),
                                  Container(
                                    child: RoundedInputPlainField(
                                      onChanged: (value) {
                                        String candidateId = candidates[i]["id"].toString();
                                        result[candidateId] = value;

                                        //print(result);
                                      },
                                    ),
                                  ),
                                  Divider(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          Card(
                            child: Container(
                              margin: EdgeInsets.all(30),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("STATION REMARK OR COMMENT",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[400],
                                          fontSize: 14,
                                        )),
                                    Container(
                                      child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        onChanged: (value) {
                                          payload["remark"] = value;
                                        },
                                        autofocus: true,
                                        style: TextStyle(fontSize: 14),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(10),
                              child: RoundedButton(
                                  color: Colors.green[600],
                                  text: "PREVIEW ENTRIES",
                                  press: () async {
                                    if (payload["station_code"] == "" ||
                                        payload["station_code"] == null) {
                                      toast(
                                          "You must enter Polling Station ID");
                                      return;
                                    }

                                    String stationCode =
                                        await MyFunctions.getLoggedInData(
                                            "station_code");

                                    //print(stationCode);

                                    if (stationCode !=
                                        payload["station_code"]) {
                                      toast(
                                          "Polling station code does not match the logged in User");
                                      return;
                                    }

                                    //result.removeWhere((key, value) => key == "0");

                                    Map post = {
                                      "station_code": payload["station_code"],
                                      "result": result,
                                      "remark": payload["remark"]
                                    };

                                    //print(post);
                                    //print(candidates);
                                    Map previewData = {
                                      "results": post,
                                      "candidates": candidates
                                    };
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ParliamentaryPreview(
                                            payload: previewData,
                                          );
                                        },
                                      ),
                                    );
                                  })),
                          SizedBox(height: 300),
                        ])),
          )),
        ));
  }
}
