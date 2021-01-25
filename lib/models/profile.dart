// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.status,
    this.photo,
    this.name,
    this.location,
    this.email,
    this.mobile,
  });

  bool status;
  String photo;
  String name;
  String location;
  String email;
  String mobile;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    status: json["status"],
    photo: json["photo"],
    name: json["name"],
    location: json["location"],
    email: json["email"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "photo": photo,
    "name": name,
    "location": location,
    "email": email,
    "mobile": mobile,
  };
}
