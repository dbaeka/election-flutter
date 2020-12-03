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

class SavePreview extends StatefulWidget {
  final Map payload;

  // receive data from the FirstScreen as a parameter
  SavePreview({Key key, @required this.payload}) : super(key: key);

  @override
  SavePreviewState createState() => SavePreviewState(payload: payload);
}

class SavePreviewState extends State<SavePreview> {
  final Map payload;

  File _image;
  String base64Image = "";
  String filename;
  bool imageUploadComplete = true;
  final picker = ImagePicker();

  //TextEditingController _msgController = new TextEditingController();

  // receive data from the FirstScreen as a parameter
  SavePreviewState({Key key, @required this.payload}) : super();

  GlobalKey<ScaffoldState> scaffoldKey;

  SizedBox divider = SizedBox(height: 20);

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
        //print(filename);
        //print("base64Image:::" + base64Image);
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
        appBar: AppBar(title: Text('Save Preview')),
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
                            child: Text("STATION ID:  " + payload["stationId"],
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
                              "${payload["result"]["npp"]}",
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
                              "${payload["result"]["ndc"]}",
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
                              "${payload["result"]["gum"]}",
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
                              "${payload["result"]["cpp"]}",
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
                              "${payload["result"]["gfp"]}",
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
                              "${payload["result"]["gcpp"]}",
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
                              "${payload["result"]["apc"]}",
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
                              "${payload["result"]["lpg"]}",
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
                              "${payload["result"]["pnc"]}",
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
                              "${payload["result"]["ppp"]}",
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
                              "${payload["result"]["ndp"]}",
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
                              "${payload["result"]["indp"]}",
                              style: TextStyle(
                                fontSize: 40,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ]),
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
                                    icon: Icon(Icons.camera_alt,color: Colors.blue[700],),
                                     label: Text("Camera", style: TextStyle(color: Colors.blue[700]),),
                                     //color: Colors.blue[500],
                                    ),/*IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      color: Colors.blue[300],
                                      iconSize: 30,
                                      onPressed: getImageFromCamera),*/
                                ),
                                Expanded(
                                  child: FlatButton.icon(
                                    onPressed: getImageFromGallery, 
                                    icon: Icon(Icons.perm_media,color: Colors.blue[900],),
                                     label: Text("Gallery",style: TextStyle(color: Colors.blue[900]),)
                                    ), /*IconButton(
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
                                            "type": "results",
                                            "attributes": {
                                              "records": {
                                                "1": int.parse(
                                                    payload["result"]["npp"]),
                                                "2": int.parse(
                                                    payload["result"]["ndc"]),
                                                "3": int.parse(
                                                    payload["result"]["gum"]),
                                                "4": int.parse(
                                                    payload["result"]["cpp"]),
                                                "5": int.parse(
                                                    payload["result"]["gfp"]),
                                                "6": int.parse(
                                                    payload["result"]["gcpp"]),
                                                "7": int.parse(
                                                    payload["result"]["apc"]),
                                                "8": int.parse(
                                                    payload["result"]["lpg"]),
                                                "9": int.parse(
                                                    payload["result"]["pnc"]),
                                                "10": int.parse(
                                                    payload["result"]["ppp"]),
                                                "11": int.parse(
                                                    payload["result"]["ndp"]),
                                                "12": int.parse(
                                                    payload["result"]["indp"]),
                                              },
                                              "station_code":
                                                  payload["stationId"],
                                              "remark": payload["remark"],
                                            }
                                          }
                                        };

                                        //save the files quickly
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString(
                                            "result", jsonEncode(post));
                                        prefs.setString(
                                            "pink-sheet", base64Image);
                                        //print(post);

                                        if (base64Image == null ||
                                            base64Image == "") {
                                          toast("Add pink sheet");
                                          return;
                                        }
                                        feedbackMsg = "";
                                        try {
                                          showAlertDialog(context, "Saving...");
                                          feedbackMsg =
                                              await MyFunctions.postWithToken(
                                                  post);

                                          Navigator.pop(context);

                                          if (feedbackMsg.trim() == "201") {
                                            post = {
                                              "data": {
                                                "type": "images",
                                                "attributes": {
                                                  "content": base64Image,
                                                  "filename": filename
                                                }
                                              }
                                            };

                                            showAlertDialog(
                                                context, "Uploading image...");
                                            feedbackMsg =
                                                await MyFunctions.saveImage(
                                                    post);

                                            //print("image  " + feedbackMsg);

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
                                                subtitle: "Failed with " + feedbackMsg + " :Retry",
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
