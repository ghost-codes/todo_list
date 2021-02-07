// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

ToDo toDoFromJson(String str) => ToDo.fromJson(json.decode(str));

String clientToJson(ToDo data) => json.encode(data.toJson());

class ToDo {
  ToDo(
      {this.id,
      this.title,
      this.description,
      this.datetime,
      this.duration,
      this.activity,
      this.isDone,
      this.date});

  String id;
  String title;
  String description;
  String datetime;
  String date;
  String duration;
  String activity;
  int isDone = 0;

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        datetime: json["datetime"],
        date: json["date"],
        duration: json["duration"],
        activity: json["activity"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "datetime": datetime,
      "duration": duration,
      "activity": activity,
      "isDone": isDone,
      "date": date,
    };
  }
}
