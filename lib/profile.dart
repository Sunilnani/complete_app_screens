import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<IconData> icons=[Icons.person,Icons.alternate_email,Icons.location_on_outlined,Icons.keyboard,Icons.add_call];
  List<String> titles=["Username","E-Mail","Location","Password change","Mobile Number"];
  List<String> subtitles=["Denim Josh","DenimJosh@gmail.com","Mumbai","........","+918674848838"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        title: Text('Profile',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),
        leading: Icon(Icons.arrow_back,color: Colors.black,),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        color: Color(0xFFF7FBFE),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              CircleAvatar(
                backgroundImage:AssetImage("img/sunil.jpg"),
                radius: 48,),
              SizedBox(height: 15,),
              Text("Denim Josh",style: TextStyle(color: Color(0xFF2E3748),fontSize: 20,fontWeight: FontWeight.w500),),
              Text("mumabi",style: TextStyle(color: Color(0xFF9FA5BB),fontSize: 15),),
              SizedBox(height: 15,),
              Container(
                child: ListView.builder(
                  itemCount: titles.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index){
                    return ProfileData(
                      title: titles[index],
                      subtitle: subtitles[index],
                      icon: icons[index],
                    );
                  },
                ),
              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFFF8701)
                ),
                child: Text("LogOut",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileData extends StatelessWidget {
  const ProfileData({
    this.icon,
    this.title,
    this.subtitle,
    Key key,
  }) : super(key: key);
  final icon;
  final title;
  final subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 54,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFFFFFFF)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(icon),
                    radius: 18,
                    backgroundColor: Color(0xFFF4F8FF),
                  ),
                  SizedBox(width: 5,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,style: TextStyle(color: Color(0xFF9FA5BB),fontSize: 13),),
                      SizedBox(height: 5,),
                      Text(subtitle,style: TextStyle(color: Color(0xFF2E3748),fontSize: 12,),)
                    ],
                  )
                ],
              ),
            ),
            Container(
                child: Text("Edit",style: TextStyle(color: Colors.deepOrange,fontSize: 15),),
            )
          ],
        ),
      ),
    );
  }
}
