import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showAlertDialog(BuildContext context, String info) {
  AlertDialog alert = AlertDialog(
    content: new ListTile(
      leading: CircularProgressIndicator(),
      title: Container(margin: EdgeInsets.only(left: 5), child: Text(info)),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      //timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

void shortToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      //timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}
