import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  Timestamp? timestamp;
  String? userName;


  UserModel({this.email, this.timestamp, this.userName});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    timestamp = json['timestamp'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['timestamp'] = this.timestamp;
    data['userName'] = this.userName;
    return data;
  }
}