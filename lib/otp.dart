import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_app_screen/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpGenerate extends StatefulWidget {
  OtpGenerate({this.user});
  final user;
  @override
  _OtpGeneratePageState createState() => _OtpGeneratePageState();
}

class _OtpGeneratePageState extends State<OtpGenerate> {
  bool hidepassword = false;

  bool loading = false;

  dynamic res;

  final  numberController = TextEditingController();



  Future<void> performLogin() async{
    String number = numberController.text.trim();


    if (number.isEmpty ) {
      Fluttertoast.showToast(msg: "Invalid Number");
      return;
    }

    setState(() {
      loading = true;
    });
    FormData formData = FormData.fromMap({
      "otp": number,

    });
    Response response =
    await Dio().post("https://networkintern.herokuapp.com/api/otp/validate",
        data: formData,
        options: Options(
          validateStatus: (status) => status < 500,
        ));
    setState(() {
      res = response.data;
      loading = false;
    });
    if (response.data['status']) {

      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  HomePage()));
    }
    else{
      Fluttertoast.showToast(msg: response.data['message']);
      print(response.data['message']);
    }
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 191 , horizontal: 25),
        child: Column(
          children: [
            Text("Verification" , style: TextStyle(color: Color(0xff2E3748) ,
                fontSize: 35, fontWeight: FontWeight.w400),),
            SizedBox(height: 15,),
            Flexible(child: Text("6 - Digit PIN has been sent to your phone, " ,style: TextStyle(color: Color(0xff9FA5BB) ,
                fontSize: 14 ),)),
            SizedBox(height: 3,),
            Flexible(child: Text("enter it below to continue.",style: TextStyle(color: Color(0xff9FA5BB) ,fontSize: 14))),
            SizedBox(height: 63,),
            TextField(
              controller:  numberController,
            ) ,

            SizedBox(height: 30,),
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF3B83FC33),
                          offset: Offset(0, 5),
                          blurRadius: 10
                      )
                    ]
                ),
                child: RaisedButton(onPressed: (){
                  setState(() {
                    performLogin();
                  });
                } ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color(0xffFF8701),
                    child: Text("Confirm" , style: TextStyle(color: Color(0xFFFFFFFF) ,
                        fontSize: 14),)),
              ),
          ],
        ),
      ),
    );
  }
}