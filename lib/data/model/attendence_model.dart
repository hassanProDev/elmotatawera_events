import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  static const String keyAttendanceData = "attendanceData";
  static const String keyDateTime = "dateTime";
  static const String keyDocId = "docId";

  final DateTime? dateTime;
  final AttendanceData attendanceData;
  final String docId;

  const AttendanceModel(
      {this.dateTime, required this.docId, required this.attendanceData});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      dateTime: (json[keyDateTime] as Timestamp).toDate(),
      docId: json[keyDocId],
      attendanceData: AttendanceData.from(jsonDecode(json[keyAttendanceData])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyAttendanceData: jsonEncode(attendanceData.toJson()),
      keyDateTime: DateTime.now(),
      keyDocId: docId,
    };
  }
}

class AttendanceData {
  static const String keyFirstName = "firstName";
  static const String keyLastName = "lastName";
  static const String keyTitle = "title";
  static const String keyAttendedWithId = "attendedWithId";
  static const String keyUid = "uid";
  static const String keyAttendId = "attendId";
  static const String keyAttendanceCount = "attendanceCount";

  final String title;
  final String attendedWithId;
  final String firstName;
  final String lastName;
  final String uid;
  String? attendId;
  int? attendanceCount;

  AttendanceData(
      {required this.title,
      required this.firstName,
      required this.lastName,
      required this.uid,
      this.attendId,
      required this.attendedWithId,
      required this.attendanceCount});

  factory AttendanceData.from(Map<String, dynamic> json) {
    return AttendanceData(
      attendId: json[keyAttendId],
      uid: json[keyUid],
      firstName: json[keyFirstName],
      lastName: json[keyLastName],
      title: json[keyTitle],
      attendedWithId: json[keyAttendedWithId],
      attendanceCount: json[keyAttendanceCount],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyAttendId: attendId,
      keyUid: uid,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyTitle: title,
      keyAttendedWithId: attendedWithId,
      keyAttendanceCount: attendanceCount
    };
  }
}
