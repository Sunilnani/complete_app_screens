import 'package:flutter/material.dart';
class OtpGenerate extends StatefulWidget {
  OtpGenerate({this.user});

  final String user;
  @override
  _OtpGenerateState createState() => _OtpGenerateState();
}

class _OtpGenerateState extends State<OtpGenerate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Welcome Sunil"),
      ),
    );
  }
}
