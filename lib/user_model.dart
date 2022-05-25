// To parse this JSON data, do
//
//     final modeluser = modeluserFromJson(jsonString);

import 'dart:convert';

Modeluser modeluserFromJson(String str) => Modeluser.fromJson(json.decode(str));

String modeluserToJson(Modeluser data) => json.encode(data.toJson());

class Modeluser {
  Modeluser({
    required this.name,
    required this.job,
    required this.id,
    required this.createdAt,
  });

  String name;
  String job;
  String id;
  String createdAt;

  factory Modeluser.fromJson(Map<String, dynamic> json) => Modeluser(
        name: json["name"],
        job: json["job"],
        id: json["id"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "id": id,
        "createdAt": createdAt,
      };
}
