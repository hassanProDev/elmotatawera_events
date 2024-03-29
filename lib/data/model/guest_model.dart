import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class GuestModel {
  static const String keyUid = "uid";
  static const String keyDocId = "docId";
  static const String keyIsConfirmed = "isConfirmed";
  static const String keyRegistrationDate = "registrationDate";
  static const String keyGuestData = "guestDate";
  static const String keyGid = "gid";


  final GuestData guestData;
  final String uid;
  final String docId;
  bool isConfirmed;
  final DateTime? registrationDate;
  String? gid;

  GuestModel({
    required this.guestData,
    required this.uid,
    required this.docId,
    this.gid,
    required this.isConfirmed,
    this.registrationDate,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) {
    return GuestModel(
      guestData: GuestData.fromJson(jsonDecode(json[keyGuestData])),
      uid: json[keyUid],
      gid: json[keyGid],
      docId: json[keyDocId],
      isConfirmed: json[keyIsConfirmed],
      registrationDate: (json[keyRegistrationDate] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyGuestData: jsonEncode(guestData.toJson()),
      keyUid: uid,
      keyDocId: docId,
      keyGid: gid,
      keyIsConfirmed: isConfirmed,
      keyRegistrationDate: DateTime.now()
    };
  }

  Map<String, dynamic> toQrCode() {
    return {
      keyGuestData: jsonEncode(guestData.toJson()),
      keyUid: uid,
      keyDocId: docId,
      keyGid: gid,
      keyIsConfirmed: isConfirmed,
      keyRegistrationDate:
          registrationDate?.toString() ?? DateTime.now().toString()
    };
  }

  factory GuestModel.fromQrCode(Map<String, dynamic> json) {
    return GuestModel(
      guestData: GuestData.fromJson(jsonDecode(json[keyGuestData])),
      uid: json[keyUid],
      gid: json[keyGid],
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
  static const String keyPaid = "paid";
  static const String keyAdminPhone = "adminPhone";
  static const String keyAvailableInvite = "availableInvite";
  static const String keyAttendanceId = "attendanceId";

  final String phone;
  final String firstName;
  final String lastName;
  int peopleCount;
  final String titleEvent;
  final DateTime eventDate;
  final String adminPhone;
  bool attendance;
  final bool paid;
  int availableInvite;
  String? attendanceId;

  GuestData({
    required this.firstName,
    required this.lastName,
    required this.peopleCount,
    required this.phone,
    required this.adminPhone,
    required this.paid,
    required this.eventDate,
    required this.titleEvent,
    required this.attendance,
    required this.availableInvite,
    this.attendanceId
  });

  factory GuestData.fromJson(Map<String, dynamic> json) {
    return GuestData(
      paid: json[keyPaid],
      adminPhone: json[keyAdminPhone],
      firstName: json[keyFirstName],
      lastName: json[keyLastName],
      peopleCount: json[keyPeopleCount],
      phone: json[keyPhone],
      eventDate: DateTime.parse(json[keyEventDate]),
      titleEvent: json[keyTitleInvitation],
      attendance: json[keyAttendance],
      availableInvite: json[keyAvailableInvite],
      attendanceId: json[keyAttendanceId],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyPaid: paid,
      keyAdminPhone: adminPhone,
      keyTitleInvitation: titleEvent,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyPhone: phone,
      keyPeopleCount: peopleCount,
      keyAttendance: attendance,
      keyEventDate: eventDate.toString(),
      keyAvailableInvite: availableInvite,
      keyAttendanceId:attendanceId
    };
  }
}
