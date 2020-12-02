import 'package:flutter/material.dart';
import 'package:flutter_auth/controllers/my-functions.dart';

class ViewUploadResult extends StatefulWidget {
  final Map payload;

  // receive data from the FirstScreen as a parameter
  ViewUploadResult({Key key, @required this.payload}) : super(key: key);

  @override
  ViewUploadResultState createState() =>
      ViewUploadResultState(payload: payload);
}

class ViewUploadResultState extends State<ViewUploadResult> {
  final Map payload;

  //TextEditingController _msgController = new TextEditingController();

  // receive data from the FirstScreen as a parameter
  ViewUploadResultState({Key key, @required this.payload}) : super();

  GlobalKey<ScaffoldState> scaffoldKey;

  SizedBox divider = SizedBox(height: 20);

  Map header;

  @override
  void initState() {
    super.initState();

    print(payload["image_url"]);

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
                child: Container(
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
                            child: Text("${payload["1"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                            child: Text("${payload["2"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                            child: Text("${payload["3"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                            child: Text("${payload["4"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                            child: Text("${payload["5"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                            child: Text("${payload["6"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                            child: Text("${payload["7"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                            child: Text("${payload["8"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                            child: Text("${payload["9"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                            child: Text("${payload["10"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                            child: Text("${payload["11"]}",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
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
                              child: Text("${payload["12"]}",
                                  style: TextStyle(
                                    fontSize: 40,
                                  ))),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.05),
                      
                      payload["image_url"].toString() == "null" || header == null
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
                                      image: NetworkImage("${payload["image_url"]}", headers: header)
                                    )
                                  ),
                                child: Container(),
                              ),
                            ),
                      SizedBox(height: 300),
                    ])),
              )),
            )));
  }
}
