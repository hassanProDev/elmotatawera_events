import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class GuestModel {
  static const String keyGid = "gid";
  static const String keyUid = "uid";
  static const String keyDocId = "docId";
  static const String keyIsConfirmed = "isConfirmed";
  static const String keyRegistrationDate = "registrationDate";
  static const String keyGuestData = "guestDate";

  final GuestData guestData;
  final String? gid;
  final String uid;
  final String docId;
  final bool isConfirmed;
  final DateTime? registrationDate;

  const GuestModel({
    required this.guestData,
    this.gid,
    required this.uid,
    required this.docId,
    required this.isConfirmed,
    this.registrationDate,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) {
    return GuestModel(
      guestData: GuestData.fromJson(jsonDecode(json[keyGuestData])),
      gid: json[keyGid],
      uid: json[keyUid],
      docId: json[keyDocId],
      isConfirmed: json[keyIsConfirmed],
      registrationDate: (json[keyRegistrationDate] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyGuestData: jsonEncode(guestData.toJson()),
      keyGid: uid + docId,
      keyUid: uid,
      keyDocId: docId,
      keyIsConfirmed: isConfirmed,
      keyRegistrationDate: DateTime.now()
    };
  }

  Map<String, dynamic> toQrCode() {
    return {
      keyGuestData: jsonEncode(guestData.toJson()),
      keyGid: uid + docId,
      keyUid: uid,
      keyDocId: docId,
      keyIsConfirmed: isConfirmed,
      keyRegistrationDate:
          registrationDate?.toString() ?? DateTime.now().toString()
    };
  }

  factory GuestModel.fromQrCode(Map<String, dynamic> json) {
    return GuestModel(
      guestData: GuestData.fromJson(jsonDecode(json[keyGuestData])),
      gid: json[keyGid],
      uid: json[keyUid],
      docId: json[keyDocId],
      isConfirmed: json[keyIsConfirmed],
      registrationDate: DateTime.parse(json[keyRegistrationDate]),
    );
  }
}

class GuestData {
  static const String keyPhone = "phone";
  static const String keyPeopleCount = "peopleCount";
  static const String keyEventDate = "eventDate";
  static const String keyTitleInvitation = "titleInvitation";
  static const String keyFirstName = "firstName";
  static const String keyLastName = "lastName";
  static const String keyAttendance = "attendance";

  final String phone;
  final String firstName;
  final String lastName;
  final int peopleCount;
  final String titleEvent;
  final DateTime eventDate;
  bool attendance;

   GuestData(
      {required this.firstName,
      required this.lastName,
      required this.peopleCount,
      required this.phone,
      required this.eventDate,
      required this.titleEvent,
      required this.attendance});

  factory GuestData.fromJson(Map<String, dynamic> json) {
    return GuestData(
      firstName: json[keyFirstName],
      lastName: json[keyLastName],
      peopleCount: json[keyPeopleCount],
      phone: json[keyPhone],
      eventDate: DateTime.parse(json[keyEventDate]),
      titleEvent: json[keyTitleInvitation],
      attendance: json[keyAttendance],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyTitleInvitation: titleEvent,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyPhone: phone,
      keyPeopleCount: peopleCount,
      keyAttendance: attendance,
      keyEventDate: eventDate.toString()
    };
  }
}
