import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/SavePreviewPage.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_plain_field.dart';
import 'package:flutter_auth/controllers/my-functions.dart';
import 'package:flutter_auth/modals.dart';

String pollingStationId = "";
String npp = "0";
String ndc = "0";
String gum = "0";
String cpp = "0";
String gfp = "0";
String gcpp = "0";
String apc = "0";
String lpg = "0";
String pnc = "0";
String ppp = "0";
String ndp = "0";
String indp = "0";
String remark = "";

class Body extends StatelessWidget {
  const Body({
    Key key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                                  pollingStationId = value;
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
                        child: RoundedInputPlainField(
                          onChanged: (value) {
                            npp = value;
                          },
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
                      child: Container(child: RoundedInputPlainField(
                        onChanged: (value) {
                          ndc = value;
                        },
                      )),
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
                      child: Container(child: RoundedInputPlainField(
                        onChanged: (value) {
                          gum = value;
                        },
                      )),
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
                        child: RoundedInputPlainField(
                          onChanged: (value) {
                            cpp = value;
                          },
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
                      child: Container(child: RoundedInputPlainField(
                        onChanged: (value) {
                          gfp = value;
                        },
                      )),
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
                      child: Container(child: RoundedInputPlainField(
                        onChanged: (value) {
                          gcpp = value;
                        },
                      )),
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
                      child: Container(child: RoundedInputPlainField(
                        onChanged: (value) {
                          apc = value;
                        },
                      )),
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
                      child: Container(child: RoundedInputPlainField(
                        onChanged: (value) {
                          lpg = value;
                        },
                      )),
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
                      child: Container(child: RoundedInputPlainField(
                        onChanged: (value) {
                          pnc = value;
                        },
                      )),
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
                      child: Container(child: RoundedInputPlainField(
                        onChanged: (value) {
                          ppp = value;
                        },
                      )),
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
                      child: Container(child: RoundedInputPlainField(
                        onChanged: (value) {
                          ndp = value;
                        },
                      )),
                    ),
                  ]),
                  Divider(),
                  SizedBox(height: size.height * 0.05),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text("INDPT",
                            style: TextStyle(
                              fontSize: 40,
                            )),
                      ),
                    ),
                    Expanded(
                      child: Container(child: RoundedInputPlainField(
                        onChanged: (value) {
                          indp = value;
                        },
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
                                  remark = value;
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
                            if (pollingStationId == "" ||
                                pollingStationId == null) {
                              toast("You must enter Polling Station ID");
                              return;
                            }

                             String stationCode = await MyFunctions.getLoggedInData("station_code");

                              if (stationCode != pollingStationId) {
                                toast("Polling station code does not match the logged in User");
                                return;
                              }

                            Map payload = {
                              "stationId": pollingStationId,
                              "result": {
                                "npp": npp,
                                "ndc": ndc,
                                "gum": gum,
                                "cpp": cpp,
                                "gfp": gfp,
                                "gcpp": gcpp,
                                "apc": apc,
                                "lpg": lpg,
                                "pnc": pnc,
                                "ppp": ppp,
                                "ndp": ndp,
                                "indp": indp,
                              },
                              "remark": remark
                            };

                            print(payload);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SavePreview(
                                    payload: payload,
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
