import 'package:flutter/material.dart';

class MyJiivo extends StatelessWidget {
  MyJiivo({this.user});

  final String user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(user),
      ),
    );
  }
}
