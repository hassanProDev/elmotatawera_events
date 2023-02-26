import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  static const String keyUid = "uid";
  static const String keyDateTime = "dateTime";
  static const String keyFirstName = "firstName";
  static const String keyLastName = "lastName";
  static const String keyTitle = "title";
  static const String keyDocId = "docId";
  static const String keyAttendedWithId = "attendedWithId";

  final DateTime? dateTime;
  final String firstName;
  final String lastName;
  final String uid;
  final String docId;
  final String title;
  final String attendedWithId;

  const AttendanceModel(
      {required this.title,
      required this.firstName,
      required this.lastName,
      this.dateTime,
      required this.uid,
      required this.docId,
      required this.attendedWithId});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
        uid: json[keyUid],
        firstName: json[keyFirstName],
        lastName: json[keyLastName],
        title: json[keyTitle],
        dateTime: (json[keyDateTime] as Timestamp).toDate(),
        docId: json[keyDocId],
        attendedWithId: json[keyAttendedWithId]);
  }


  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyTitle: title,
      keyDateTime: DateTime.now(),
      keyDocId: docId,
      keyAttendedWithId: attendedWithId
    };
  }
}
