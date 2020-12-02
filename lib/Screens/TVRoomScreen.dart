import 'dart:ui';

import 'package:flutter/material.dart';

class TVRoomScreen extends StatefulWidget {
  // receive data from the FirstScreen as a parameter
  TVRoomScreen() : super();

  @override
  TVRoomState createState() => TVRoomState();
}

class TVRoomState extends State<TVRoomScreen> {
   String id;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('GhanaDecides\'20')),
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
                        //margin: EdgeInsets.all(30),
                        child: Center(
                          child:  Container(
                                width: size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey[200],
                                ),
                                child: Image.asset(
                                  'assets/images/gh-decides.png', 
                                  fit: BoxFit.contain,
                                ) //AssetImage('assets/images/ec-pinksheet.jpg'),
                                ),
                        ),
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                width: size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey[200],
                                ),
                                child: Image.asset(
                                  'assets/images/npp.png',
                                  fit: BoxFit.contain,
                                ) //AssetImage('assets/images/ec-pinksheet.jpg'),
                                ),
                                Text("NPP - 35.00%",
                                    style: TextStyle(
                                      fontSize: 35.00,
                                      color: Color(0xFF000089)
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                width: size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey[200],
                                ),
                                child: Image.asset(
                                  'assets/images/ndc.png', 
                                  fit: BoxFit.contain,
                                ) //AssetImage('assets/images/ec-pinksheet.jpg'),
                                ),
                                Text(
                                  "NDC 35.00%",
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Color(0xff00380d)
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      Divider(),
                      SizedBox(height: size.height * 0.05),
                      Container(
                        child: Text("The Numbers",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right:10),
                            //width: size.width * 0.45,
                            height: size.width * 0.25,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                              color: Colors.grey[200],
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/nana2.png')
                              )   
                            ),
                            child: Container(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: EdgeInsets.only(bottom:5,right: 5),
                                  child: Text("4,345,981", style: TextStyle(
                                    color: Colors.grey[50],
                                    fontSize: 30.00,
                                  ),
                                  ),
                                ),
                              ),
                            ) //AssetImage('assets/images/ec-pinksheet.jpg'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right:10),
                            //width: size.width * 0.45,
                            height: size.width * 0.25,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                              color: Colors.grey[200],
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/jm2.png')
                              )   
                            ),
                            child: Container(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: EdgeInsets.only(bottom:5,right: 5),
                                  child: Text("4,345,981", style: TextStyle(
                                    color: Colors.grey[50],
                                    fontSize: 30.00,
                                  ),),
                                ),
                              ),
                            ) //AssetImage('assets/images/ec-pinksheet.jpg'),
                          ),
                        ),
                      ]),
                      Divider(),
                      SizedBox(height: size.height * 0.05),
                      Container(
                        child: Text("Others",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
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
                              "45-0.12%",
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
                              "98-0.13%",
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
                            child: Text("GFP-0.12%",
                                style: TextStyle(
                                  fontSize: 40,
                                )),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              "78-0.12%",
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
                              "96-0.12%",
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
                              "1-0.12%",
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
                              "23-0.12%",
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
                              "54-0.12%",
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
                              "0-0.12%",
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
                              "96-0.12%",
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
                              "3-0.12%",
                              style: TextStyle(
                                fontSize: 40,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.05),
                     
                      SizedBox(height: 300),
                    ])),
              )),
            )));
  }
}
