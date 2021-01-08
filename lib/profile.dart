import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_app_screen/home.dart';

import 'models/profile.dart';


class ProfileClass extends StatefulWidget {
  @override
  _ProfileClassState createState() => _ProfileClassState();
}

class _ProfileClassState extends State<ProfileClass> {
  Profile listTodos = Profile();
  bool fetching = true;
  void getHttp() async {
    setState(() {
      fetching = true;
    });
    try {
      Response response =
      await Dio().get("https://networkintern.herokuapp.com/api/profile");
      setState(() {
        listTodos = profileFromJson(jsonEncode(response.data)) ;
        fetching = false;
        print(response);
      });
    } catch (e) {
      setState(() {
        fetching = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    getHttp();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (fetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (listTodos.photo.length == 0) {
      return Center(
        child: Text("No Data"),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        elevation: 2,
        shadowColor: Color(0xff00000D),

        leading: IconButton(icon: Icon(Icons.arrow_back_sharp ,size: 25, color:Color(0xff000000)) ,onPressed: (){
          Navigator.pop(context);
        }, ),
        titleSpacing: 0,
        title: Text("Profile" , style: TextStyle(color: Color(0xff000000),fontSize: 17),),
      ),
      body: SingleChildScrollView(
        child:  Container(
          color: Color(0xffF7FBFE) ,
          margin: EdgeInsets.symmetric(vertical: 30 ,horizontal:23 ),
          child: Column(
            children: [

              Container(
                alignment: Alignment.center,
                child: CircleAvatar(

                  backgroundImage: NetworkImage("${listTodos.photo}"),
                  radius: 50,
                ),
              ),
              SizedBox(height: 21,),
              Container(
                alignment: Alignment.center,
                child: Text("${listTodos.name}" ,style: TextStyle(color:Color(0xff2E3748) , fontSize: 20 ,)
                ),
              ),
              SizedBox(height: 2,),
              Container(
                alignment: Alignment.center,
                child: Text("${listTodos.location}" ,style: TextStyle(color:Color(0xff9FA5BB) , fontSize: 15 ,)
                ),
              ),
              SizedBox(height:15,),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 14 , horizontal: 18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff0000000D),
                              offset: Offset(0,3),
                              blurRadius: 20
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xffF4F8FF),
                              child: Icon(Icons.person , color: Color(0xff2E3748),),
                            ),
                            SizedBox(width: 16,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Username" , style:TextStyle(color: Color(0xff9FA5BB) , fontWeight: FontWeight.w500,fontSize: 13), ),
                                SizedBox(height: 5,),
                                Text("${listTodos.name}" , style: TextStyle(color: Color(0xff2E3748), fontWeight: FontWeight.w500 , fontSize: 12),
                                ),

                              ],
                            ),
                          ],
                        ),

                        Text("Edit", style: TextStyle(color: Color(0xffFF8701), fontWeight: FontWeight.w500 , fontSize: 15),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 10,),


                ],
              ),
              SizedBox(height: 10,),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 14 , horizontal: 18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff0000000D),
                              offset: Offset(0,3),
                              blurRadius: 20
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xffF4F8FF),
                              child: Text("@" , style: TextStyle(color: Color(0xff2E3748) ,fontSize: 18 ,fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(width: 16,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("E-mail" , style:TextStyle(color: Color(0xff9FA5BB) , fontWeight: FontWeight.w500,fontSize: 13), ),
                                SizedBox(height: 5,),
                                Text("${listTodos.email}" , style: TextStyle(color: Color(0xff2E3748), fontWeight: FontWeight.w500 , fontSize: 12),
                                ),

                              ],
                            ),
                          ],
                        ),

                        Text("Edit", style: TextStyle(color: Color(0xffFF8701), fontWeight: FontWeight.w500 , fontSize: 15),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 10,),


                ],
              ),
              SizedBox(height: 10,),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 14 , horizontal: 18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff0000000D),
                              offset: Offset(0,3),
                              blurRadius: 20
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xffF4F8FF),
                              child: Icon(Icons.location_on_outlined , color: Color(0xff2E3748),),
                            ),
                            SizedBox(width: 16,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Location" , style:TextStyle(color: Color(0xff9FA5BB) , fontWeight: FontWeight.w500,fontSize: 13), ),
                                SizedBox(height: 5,),
                                Text("${listTodos.location}" , style: TextStyle(color: Color(0xff2E3748), fontWeight: FontWeight.w500 , fontSize: 12),
                                ),

                              ],
                            ),
                          ],
                        ),

                        Text("Edit", style: TextStyle(color: Color(0xffFF8701), fontWeight: FontWeight.w500 , fontSize: 15),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 10,),


                ],
              ),
              SizedBox(height: 10,),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 14 , horizontal: 18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff0000000D),
                              offset: Offset(0,3),
                              blurRadius: 20
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xffF4F8FF),
                              child: Icon(Icons.phone, color: Color(0xff2E3748),),
                            ),
                            SizedBox(width: 16,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mobile No." , style:TextStyle(color: Color(0xff9FA5BB) , fontWeight: FontWeight.w500,fontSize: 13), ),
                                SizedBox(height: 5,),
                                Text("${listTodos.mobile}" , style: TextStyle(color: Color(0xff2E3748), fontWeight: FontWeight.w500 , fontSize: 12),
                                ),

                              ],
                            ),
                          ],
                        ),

                        Text("Edit", style: TextStyle(color: Color(0xffFF8701), fontWeight: FontWeight.w500 , fontSize: 15),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 10,),


                ],
              ),



              SizedBox(height: 10,),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffFF87011a),
                          offset: Offset(0, 5),
                          blurRadius: 10
                      )
                    ]
                ),
                child: RaisedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                } ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color(0xffFF8701),
                    child: Text("Logout" , style: TextStyle(color: Color(0xFFFFFFFF) ,
                        fontSize: 14),)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}