import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/controllers/my-functions.dart';

class ViewUploadedPmResult extends StatefulWidget {
  final Map payload;

  // receive data from the FirstScreen as a parameter
  ViewUploadedPmResult({Key key, @required this.payload}) : super(key: key);

  @override
  ViewUploadResultState createState() =>
      ViewUploadResultState(payload: payload);
}

class ViewUploadResultState extends State<ViewUploadedPmResult> {
  final Map payload;

  //TextEditingController _msgController = new TextEditingController();

  // receive data from the FirstScreen as a parameter
  ViewUploadResultState({Key key, @required this.payload}) : super();

  GlobalKey<ScaffoldState> scaffoldKey;

  SizedBox divider = SizedBox(height: 20);

  Map header;

  List candidates;

  @override
  void initState() {
    super.initState();

    //print(payload);

    _loadNetImage();

    _parliamentaryCandidates();
  }

  _parliamentaryCandidates() async {
    String data = await MyFunctions.parliamentaryCandidates();
    setState(() {
      candidates = jsonDecode(data)["data"];

      //print(candidates);
    });
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
                child: (candidates == null)
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        margin: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(30),
                            child: Center(
                              child: Text("${payload["time"]}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87)),
                            ),
                          ),
                          for (var i = 0; i < candidates.length; i++)
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Row(children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                            candidates[i]["attributes"]
                                                    ["party_short_name"]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 40,
                                            )),
                                        Text(
                                            candidates[i]["attributes"]["name"]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                        (payload[candidates[i]["id"].toString()].toString() == "null")
                                            ? "0"
                                            : payload[candidates[i]["id"].toString()].toString(),
                                        style: TextStyle(
                                          fontSize: 40,
                                        )),
                                  ),
                                ),
                              ]),
                            ),
                          Divider(),
                          SizedBox(height: size.height * 0.05),
                          payload["image_url"].toString() == "null" ||
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
                                                "${payload["image_url"]}",
                                                headers: header))),
                                    child: Container(),
                                  ),
                                ),
                          SizedBox(height: 300),
                        ])),
              )),
            )));
  }
}
