import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_app_screen/home.dart';
import 'package:flutter_complete_app_screen/response_authentications/base_response.dart';
import 'package:flutter_complete_app_screen/response_authentications/login_authentication.dart';
import 'package:flutter_complete_app_screen/response_authentications/signup_authentication.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_network.dart';
import 'otp.dart';
class SignUp extends StatefulWidget {
  SignUp({this.user});
  final user;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool hidepassword=false;
  bool _loading = false;

  dynamic res;

  Future<void> _performLogin() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String mobile = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid name");
      return;
    }
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid email");
      return;
    }

    if (mobile.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid number");
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid password");
      return;
    }
    setState(() {
      _loading = true;
    });
    // Map<String, dynamic> postData = {
    //   "username": username,
    //   "password": password,
    // };
    Map<String,dynamic > data = {
      "mobile": mobile,
      "password": password,
      "name":name,
      "email":email
    };
    ResponseData responseData = await signupManager.createLoginToken(data);
    setState(() {
      res = responseData.data;
      _loading = false;
    });
    if (responseData.status == ResponseStatus.SUCCESS) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OtpGenerate( 
            user: responseData.data['user'] ??
                "", // response.data['user'] == null ? "" : response.data['user']
          ),
        ),
      );
      // Navigate forward
    } else {
      Fluttertoast.showToast(msg: responseData.message);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 25,vertical: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 120,),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Sign Up",style: TextStyle(color: Color(0xFF2E3748),fontSize: 35,fontWeight: FontWeight.w700),)),
                SizedBox(height: 20,),
                Container(
                  height: 48,
                  child: TextField(
                    controller:_nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Color(0x01FF8701)),borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Color(0xFFFF8701),width: 2)
                        ),
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Color(0xFFFF8701)),
                        hintText: 'Denom'),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 48,
                  child: TextField(
                    controller:_emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Color(0x01FF8701)),borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Color(0xFFFF8701),width: 2)
                        ),
                        labelText: 'E-mail',
                        labelStyle: TextStyle(color: Color(0xFFFF8701)),
                        hintText: 'Leha@gmail.com'),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 48,
                  child: TextField(
                    controller:_usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Color(0x01FF8701)),borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Color(0xFFFF8701),width: 2)
                        ),
                        labelText: 'Number',
                        labelStyle: TextStyle(color: Color(0xFFFF8701)),
                        hintText: '+91'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 48,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: hidepassword,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Color(0xFFFF8701),width: 2)
                        ),
                        suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                hidepassword= !hidepassword;
                              });
                            },
                            icon:Icon(hidepassword?Icons.visibility_off:Icons.visibility)
                        ),
                        labelText: 'password',
                        labelStyle: TextStyle(color: Color(0xFFFF8701)),
                        hintText: 'password'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                if (_loading)
                  Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFFF8701), borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF87011A),
                          offset: const Offset(
                            0.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: FlatButton(
                      onPressed: () {
                        _performLogin();
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                SizedBox(height: 25,),
                Text("-OR-",style: TextStyle(color: Color(0xFF000000)),),
                SizedBox(height: 18,),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Color(0xFFE3EAF2),
                        width: 2,
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("img/google.png",height: 25,),
                      Text("Sign in with google",style: TextStyle(fontSize: 14),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
