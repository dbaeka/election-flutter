import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/controllers/my-functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import '../modals.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:path/path.dart';

class ParliamentaryPreview extends StatefulWidget {
  final Map payload;

  // receive data from the FirstScreen as a parameter
  ParliamentaryPreview({Key key, @required this.payload}) : super(key: key);

  @override
  ParliamentaryPreviewState createState() =>
      ParliamentaryPreviewState(payload: payload);
}

class ParliamentaryPreviewState extends State<ParliamentaryPreview> {
  final Map payload;

  File _image;
  String base64Image = "";
  String filename;
  bool imageUploadComplete = true;
  final picker = ImagePicker();
  List candidates = [];
  Map results = {};
  Map onlyResults = {};
  //TextEditingController _msgController = new TextEditingController();

  // receive data from the FirstScreen as a parameter
  ParliamentaryPreviewState({Key key, @required this.payload}) : super();

  GlobalKey<ScaffoldState> scaffoldKey;

  SizedBox divider = SizedBox(height: 20);

  @override
  void initState() {
    super.initState();

    //print(payload);
    setState(() {
      candidates = payload["candidates"];
      results = payload["results"];
      onlyResults = results["result"];
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        base64Image = base64Encode(_image.readAsBytesSync());
        filename = basename(_image.path);
        print(filename);
        //print("base64Image:::" + base64Image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        base64Image = base64Encode(_image.readAsBytesSync());
        filename = basename(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('Preview Parliamentary Result')),
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
                          child: Text("Check that every entry is correct",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[900],
                                fontSize: 14,
                              )),
                        ),
                      ),
                      Card(
                        child: Container(
                          margin: EdgeInsets.all(30),
                          child: Center(
                            child: Text(
                                "STATION CODE:  " + results["station_code"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                  fontSize: 14,
                                )),
                          ),
                        ),
                      ),
                      Divider(),
                      for (var i = 0; i < candidates.length; i++)
                        ListTile(
                          title: Text(
                              candidates[i]["attributes"]["name"].toString(),
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          subtitle: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          candidates[i]["attributes"]
                                                  ["party_short_name"]
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                          )),
                                    ),
                                    Text(
                                        (onlyResults[candidates[i]["id"].toString()].toString() == "null")
                                            ? "0"
                                            : onlyResults[candidates[i]["id"].toString()].toString(),
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[900])),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      //SizedBox(height: size.height * 0.05),
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
                                Text(
                                    results["remark"].toString() == "null"
                                        ? ""
                                        : results["remark"].toString(),
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
                      Card(
                        child: Container(
                          height: size.height * 0.90,
                          width: size.width * 0.90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: (_image != null)
                                      ? FileImage(_image) //FileImage(_image)
                                      : AssetImage(
                                          'assets/images/default-pink-sheet.png'))),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                                Expanded(
                                  child: FlatButton.icon(
                                    onPressed: getImageFromCamera,
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.blue[700],
                                    ),
                                    label: Text(
                                      "Camera",
                                      style: TextStyle(color: Colors.blue[700]),
                                    ),
                                    //color: Colors.blue[500],
                                  ),
                                ),
                                Expanded(
                                  child: FlatButton.icon(
                                      onPressed: getImageFromGallery,
                                      icon: Icon(
                                        Icons.perm_media,
                                        color: Colors.blue[900],
                                      ),
                                      label: Text(
                                        "Gallery",
                                        style:
                                            TextStyle(color: Colors.blue[900]),
                                      )), /*IconButton(
                                      icon: Icon(Icons.perm_media),
                                      color: Colors.blue[300],
                                      iconSize: 30,
                                      onPressed: getImageFromGallery),*/
                                ),
                              ],
                            ),
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
                                text: "EDIT",
                                press: () {
                                  Navigator.pop(context);
                                }),
                          )),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: RoundedButton(
                                      color: Colors.green[600],
                                      text: "SAVE",
                                      press: () async {
                                        //save image
                                        String feedbackMsg = "";

                                        Map post = {
                                          "data": {
                                            "type": "pm_results",
                                            "attributes": {
                                              "records": onlyResults,
                                              "station_code":
                                                  results["station_code"],
                                              "remark": results["remark"]
                                                          .toString() ==
                                                      "null"
                                                  ? ""
                                                  : results["remark"],
                                            }
                                          }
                                        };

                                        //save the files quickly
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString(
                                            "pm_results", jsonEncode(post));
                                        prefs.setString(
                                            "pm_pink_sheet", base64Image);
                                        //print(post);

                                        if (base64Image == null ||
                                            base64Image == "") {
                                          toast("Add pink sheet");
                                          return;
                                        }

                                        String stationCode =
                                            await MyFunctions.getLoggedInData(
                                                "station_code");

                                        if (stationCode !=
                                            results["station_code"]) {
                                          toast(
                                              "Polling station code does not match the logged in User");
                                          return;
                                        }
                                        //print(stationCode);
                                        //return;

                                        feedbackMsg = "";
                                        try {
                                          showAlertDialog(context, "Saving...");
                                          feedbackMsg =
                                              await MyFunctions.savePmResults(
                                                  post);

                                          Navigator.pop(context);

                                          if (feedbackMsg.trim() == "201") {
                                            post = {
                                              "data": {
                                                "type": "pm_images",
                                                "attributes": {
                                                  "content": base64Image,
                                                  "filename": filename
                                                }
                                              }
                                            };

                                            //print(post);

                                            showAlertDialog(
                                                context, "Uploading image...");
                                            feedbackMsg =
                                                await MyFunctions.savePmImage(
                                                    post);

                                            print("image  " + feedbackMsg);

                                            Navigator.pop(context);

                                            if (feedbackMsg.trim() == "201")
                                              SweetAlert.show(context,
                                                  title: "Saved",
                                                  subtitle:
                                                      "Congratulations, Result saved",
                                                  style:
                                                      SweetAlertStyle.success);
                                            else {
                                              // }
                                              SweetAlert.show(context,
                                                  title: "Failed",
                                                  subtitle:
                                                      "Image upload failed",
                                                  style: SweetAlertStyle.error);
                                            }
                                          } else {
                                            SweetAlert.show(context,
                                                title: "Failed",
                                                subtitle: "Failed with " +
                                                    feedbackMsg +
                                                    " :Retry",
                                                style: SweetAlertStyle.error);
                                          }
                                        } catch (e) {
                                          toast("Result failed to save");
                                        }
                                      }))),
                        ],
                      ),
                      SizedBox(height: 300),
                    ])),
              )),
            )));
  }
}
