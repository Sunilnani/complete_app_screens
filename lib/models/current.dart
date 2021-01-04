// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.status,
    this.events,
  });

  bool status;
  List<Event> events;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    status: json["status"],
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "events": List<dynamic>.from(events.map((x) => x.toJson())),
  };
}

class Event {
  Event({
    this.date,
    this.title,
    this.description,
    this.from,
    this.to,
    this.location,
    this.bannerImage,
    this.usersAttending,
  });

  DateTime date;
  String title;
  String description;
  String from;
  String to;
  String location;
  String bannerImage;
  List<String> usersAttending;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    date: DateTime.parse(json["date"]),
    title: json["title"],
    description: json["description"],
    from: json["from"],
    to: json["to"],
    location: json["location"],
    bannerImage: json["banner_image"],
    usersAttending: List<String>.from(json["users_attending"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "title": title,
    "description": description,
    "from": from,
    "to": to,
    "location": location,
    "banner_image": bannerImage,
    "users_attending": List<dynamic>.from(usersAttending.map((x) => x)),
  };
}
