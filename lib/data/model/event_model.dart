import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  static const String keyTitle = "title";
  static const String keyUid = "uid";
  static const String keyDescription = "description";
  static const String keyLocation = "location";
  static const String keyLocationUrl = "locationUrl";
  static const String keyPeopleCount = "peopleCount";
  static const String keyDateTime = "dateTime";
  static const String keyDocId = "docId";
  static const String keyIsPaid = "isPaid";
  static const String keyPrice = "price";
  static const String keyImg = "image";
  static const String keyPublishDate = "publishDate";
  static const String keyisEventDone = "isEventDone";

  final String title;
  final String description;
  final String location;
  final String locationUrl;
  final int peopleCount;
  final DateTime dateTime;
  final String uid;
  String docId;
  final bool isPaid;
  final double price;
  final String? img;
  final bool isEventDone;

   EventModel(
      {required this.uid,
       this.docId='',
      required this.title,
      required this.location,
      required this.dateTime,
      required this.peopleCount,
      required this.description,
      required this.price,
      required this.isPaid,
      required this.locationUrl,
      this.img,
      required this.isEventDone});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        uid: json[keyUid],
        title: json[keyTitle],
        location: json[keyLocation],
        dateTime: (json[keyDateTime] as Timestamp).toDate(),
        peopleCount: json[keyPeopleCount],
        docId: json[keyDocId],
        description: json[keyDescription],
        price: json[keyPrice],
        isPaid: json[keyIsPaid],
        locationUrl: json[keyLocationUrl],
        img: json[keyImg],
        isEventDone: json[keyisEventDone]);
  }

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyTitle: title,
      keyLocation: location,
      keyDateTime: dateTime,
      keyPeopleCount: peopleCount,
      keyDocId: docId,
      keyDescription: description,
      keyIsPaid: isPaid,
      keyPrice: price,
      keyLocationUrl: locationUrl,
      keyImg: img,
      keyPublishDate: DateTime.now(),
      keyisEventDone: isEventDone
    };
  }
}
