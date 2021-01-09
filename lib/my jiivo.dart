import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_app_screen/models/past.dart';
import 'package:flutter_complete_app_screen/profile.dart';
import 'models/current.dart';

class MyJiivo extends StatelessWidget {
  MyJiivo({this.user});

  final String user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon( Icons.search,color: Colors.black, ),
                onPressed: () { },
              ),
            ],
            backgroundColor: Colors.white,
            title: Text('My jiivo',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
            leading: Icon(Icons.menu,color: Colors.black,),
            bottom: TabBar(
              indicatorColor: Colors.deepOrange,
              labelColor: Colors.black,
              tabs: [
                Tab( text: "Current event",),
                Tab( text: "Past event"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CurrentEvent(),
              PastEvent(),
            ],
          ),
        ),
      ),
    );
  }
}
class CurrentEvent extends StatefulWidget {
  @override
  _CurrentEventState createState() => _CurrentEventState();
}

class _CurrentEventState extends State<CurrentEvent> {
  Welcomes listcurrent = Welcomes();
  bool _fetching = true;
  void getHttp() async {
    setState(() {
      _fetching = true;
    });
    try {
      Response response =
      await Dio().get("https://networkintern.herokuapp.com/api/events?type=current");
      setState(() {
        listcurrent = welcomesFromJson(jsonEncode(response.data));
        _fetching = false;
      });
      print(response);
    } catch (e) {
      setState(() {
        _fetching = false;
      });
      print(e);
    }
  }
  int pressedButtonNo ;
  @override
  void initState() {
    getHttp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFF6EE),
              offset: const Offset(
                0.0,
                2.0,
              ),
              blurRadius: 20.0,
            ), //BoxShadow
          ],
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.black12,
          buttonBackgroundColor: Color(0xFFFF8701),
          items: <Widget>[
            Icon(Icons.list, size: 35,color: (pressedButtonNo == 0)? Colors.white : Colors.black,),
            Icon(Icons.add, size: 35,color: (pressedButtonNo == 1)? Colors.white : Colors.black,),
            Icon(Icons.person, size: 35,color: (pressedButtonNo == 2)? Colors.white : Colors.black,),
          ],
          onTap: (index) {
            setState(() {
              pressedButtonNo = index;
              if (index==2){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ProfileClass()));
              }
            });
          },
        ),
      ),
      body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 20,),
                _buildBody(),
              ],
            ),
          ),
      ),
    );
  }
  Widget _buildBody() {
    if (_fetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (listcurrent.events.length == 0) {
      return Center(
        child: Text("No Data"),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: listcurrent.events.length,
        itemBuilder: (context, index) {
          Welcomes current = listcurrent;
          return CurrentEvents(
            title: current.events[index].title,
            image: current.events[index].bannerImage,
            location: current.events[index].location,
            description: current.events[index].description,
            from: current.events[index].from,
            to: current.events[index].to,
          );
        },
      ),
    );
  }
}

class CurrentEvents extends StatelessWidget {
  const CurrentEvents({
    this.title,
    this.image,
    this.location,
    this.description,
    this.from,
    this.to,
    Key key,
  }) : super(key: key);
  final String title;
  final String image;
  final String location;
  final String description;
  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 18),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF00000008),
                offset: const Offset(
                  0.0,
                  3.0,
                ),
                blurRadius: 6.0,
              ), //BoxShadow
            ],
            border: Border.all(
              color: Colors.black12,
              width: 1,
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15,vertical: 8),
                    child: Container(
                      height: 29,
                      width: 28,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Color(0xFFFF8701),
                            width: 2,
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("22",style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w500),),
                          Text("Feb",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 6),)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 68),
                      child: Text(title,style: TextStyle(color: Color(0xFF2A3E68),fontSize: 13,fontWeight: FontWeight.w500),),
                    ),
                  )
                ],
              ),
              Image.network(image),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Text(description,style: TextStyle(color: Color(0xFF2A3E68),fontSize: 16,fontWeight: FontWeight.w500),)
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Text("$from - $to  .  $location",style: TextStyle(color: Color(0xFFA1A0A0),fontSize: 13,fontWeight: FontWeight.w500),)
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:230.0,),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("img/sunil.jpg"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:240),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("img/google.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:250),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("img/event.jpg"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:260),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("img/sunil.jpg"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:270),
                      child: CircleAvatar(
                        child: Text("99+",style: TextStyle(color: Colors.white,fontSize: 8),),
                        backgroundColor: Colors.orange,
                        radius: 10,
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class PastEvent extends StatefulWidget {
  @override
  _PastEventState createState() => _PastEventState();
}

class _PastEventState extends State<PastEvent> {
  Welcoming listpast = Welcoming();
  bool _fetching = true;
  void getHttp() async {
    setState(() {
      _fetching = true;
    });
    try {
      Response response =
      await Dio().get("https://networkintern.herokuapp.com/api/events?type=past");
      setState(() {
        listpast = welcomingFromJson(jsonEncode(response.data));
        _fetching = false;
      });
      print(response);
    } catch (e) {
      setState(() {
        _fetching = false;
      });
      print(e);
    }
  }
  int pressedButtonNo ;
  @override
  void initState() {
    getHttp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFF6EE),
              offset: const Offset(
                0.0,
                2.0,
              ),
              blurRadius: 20.0,
            ), //BoxShadow
          ],
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.black12,
          buttonBackgroundColor: Color(0xFFFF8701),
          items: <Widget>[
            Icon(Icons.list, size: 35,color: (pressedButtonNo == 0)? Colors.white : Colors.black,),
            Icon(Icons.add, size: 35,color: (pressedButtonNo == 1)? Colors.white : Colors.black,),
            Icon(Icons.person, size: 35,color: (pressedButtonNo == 2)? Colors.white : Colors.black,),
          ],
          onTap: (index) {
            setState(() {
              pressedButtonNo = index;
              if (index==2){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ProfileClass()));
              }
            });
          },
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 20,),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildBody() {
    if (_fetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (listpast.events.length == 0) {
      return Center(
        child: Text("No Data"),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: listpast.events.length,
        itemBuilder: (context, index) {
          Welcoming past = listpast;
          return CurrentEvents(
            title: past.events[index].title,
            image: past.events[index].bannerImage,
            location: past.events[index].location,
            description: past.events[index].description,
            from: past.events[index].from,
            to: past.events[index].to,
          );
        },
      ),
    );
  }
}

class PastEvents extends StatelessWidget {
  const PastEvents({
    this.title,
    this.image,
    this.location,
    this.description,
    this.from,
    this.to,
    Key key,
  }) : super(key: key);
  final String title;
  final String image;
  final String location;
  final String description;
  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 18),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF00000008),
                offset: const Offset(
                  0.0,
                  3.0,
                ),
                blurRadius: 6.0,
              ), //BoxShadow
            ],
            border: Border.all(
              color: Colors.black12,
              width: 1,
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:15,vertical: 8),
                      child: Container(
                        height: 29,
                        width: 28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Color(0xFFFF8701),
                              width: 2,
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("22",style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w500),),
                            Text("Feb",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 6),)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 68),
                        child: Text(title,style: TextStyle(color: Color(0xFF2A3E68),fontSize: 13,fontWeight: FontWeight.w500),),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight    ,
                      child: Icon(Icons.favorite_border_outlined,color: Colors.orange,),
                    )
                  ],
                ),
              ),
              Image.asset(image),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Text(description,style: TextStyle(color: Color(0xFF2A3E68),fontSize: 16,fontWeight: FontWeight.w500),)
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Text("$from - $to  .  $location",style: TextStyle(color: Color(0xFFA1A0A0),fontSize: 13,fontWeight: FontWeight.w500),)
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:230.0,),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("img/sunil.jpg"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:240),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("img/google.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:250),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("img/event.jpg"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:260),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("img/sunil.jpg"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:270),
                      child: CircleAvatar(
                        child: Text("99+",style: TextStyle(color: Colors.white,fontSize: 8),),
                        backgroundColor: Colors.orange,
                        radius: 10,
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}