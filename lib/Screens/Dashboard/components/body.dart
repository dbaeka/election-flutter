import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Capture/capture_screen.dart';
import 'package:flutter_auth/Screens/Dashboard/components/background.dart';
import 'package:flutter_auth/Screens/UploadHistory.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/controllers/my-functions.dart';

class Body extends StatefulWidget {
  // receive data from the FirstScreen as a parameter
  Body({Key key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  String name = "";
  String stationId = "";
//class Body extends StatelessWidget {
  @override
  void initState() {
    super.initState();

    _loggedInDetails();
  }

  _loggedInDetails() async {
    String data = await MyFunctions.loggedInDetails();

    print(data);

    setState(() {
      var row = jsonDecode(data);
      name = row["name"].toString().toUpperCase();
      stationId = row["station_id"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "GHANA DECIDES'20",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              "NAME:$name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            /*SizedBox(height: size.height * 0.05),
            Container(
              child: Text(
                "STATION ID:$stationId",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),*/
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "ADD POLLING STATION RESULT",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CaptureScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "VIEW UPLOAD HISTORY",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UploadHistory();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
