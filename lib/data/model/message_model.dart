import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {

  static const String keyDocId = "docId";
  static const String keyDateTime = "dateTime";
  static const String keyMessageData = "messageData";


  final String docId;
  final DateTime? dateTime;
  final MessageData messageData;

  const MessageModel({
    required this.messageData,
    this.dateTime,
    required this.docId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageData: MessageData.fromJson(jsonDecode(json[keyMessageData])),
        dateTime: (json[keyDateTime] as Timestamp).toDate(),
        docId: json[keyDocId],);
  }

  Map<String, dynamic> toJson() {
    return {
      keyMessageData:jsonEncode(messageData.toJson()),
      keyDateTime: DateTime.now(),
      keyDocId: docId
    };
  }
}

class MessageData{
  static const String keyMessage = "message";
  static const String keyUid = "uid";
  static const String keyMid = "mid";

  final String message;
  final String uid;
   String? mid;

   MessageData({
    this.mid,
    required this.uid,
    required this.message,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      mid: json[keyMid],
        uid: json[keyUid],
        message: json[keyMessage]);
  }

  Map<String, dynamic> toJson() {
    return {
      keyMid:mid,
      keyMessage: message,
      keyUid: uid,
    };
  }
}
