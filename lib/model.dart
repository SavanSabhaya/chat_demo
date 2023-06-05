// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

MsgModel dataFromJson(String str) => MsgModel.fromJson(json.decode(str));

String dataToJson(MsgModel data) => json.encode(data.toJson());

class MsgModel {
  String type;
  String msg;
  String sender;

  MsgModel({
    required this.type,
    required this.msg,
    required this.sender,
  });

  factory MsgModel.fromJson(Map<String, dynamic> json) => MsgModel(
        type: json["title"],
        msg: json["first"],
        sender: json["last"],
      );

  Map<String, dynamic> toJson() => {
        "title": type,
        "first": msg,
        "last": sender,
      };
}
