import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Capture/components/body.dart';

class CaptureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result Entry')),
      body: Body(),
    );
  }
}
