// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  Client({
    this.id,
    this.title,
    this.description,
    this.datetime,
    this.duration,
    this.activity,
  });

  int id;
  String title;
  String description;
  String datetime;
  String duration;
  String activity;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        datetime: json["datetime"],
        duration: json["duration"],
        activity: json["activity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "datetime": datetime,
        "duration": duration,
        "activity": activity,
      };
}
