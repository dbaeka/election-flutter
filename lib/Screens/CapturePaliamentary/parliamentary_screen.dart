import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CapturePaliamentary/components/body.dart';

class ParliamentaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parliamentary Result Entry')),
      body: Body(),
    );
  }
}
