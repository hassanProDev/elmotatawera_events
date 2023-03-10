import 'dart:convert';

class EventModel {
  static const String keyPublishDate = "publishDate";
  static const String keyisEventDone = "isEventDone";
  static const String keyEventData = "eventData";

  final bool isEventDone;
  final EventData eventData;

  EventModel({
    required this.eventData,
    required this.isEventDone,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        eventData: EventData.form(jsonDecode(json[keyEventData])),
        isEventDone: json[keyisEventDone]);
  }

  Map<String, dynamic> toJson() {
    return {
      keyEventData: jsonEncode(eventData.toJson()),
      keyPublishDate: DateTime.now(),
      keyisEventDone: isEventDone
    };
  }
}

class EventData {
  static const String keyDocId = "docId";
  static const String keyTitle = "title";
  static const String keyUid = "uid";
  static const String keyDescription = "description";
  static const String keyLocation = "location";
  static const String keyLocationUrl = "locationUrl";
  static const String keyPeopleCount = "peopleCount";
  static const String keyDateTime = "dateTime";
  static const String keyIsPaid = "isPaid";
  static const String keyPrice = "price";
  static const String keyImg = "image";

  final String title;
  final String description;
  final String location;
  final String locationUrl;
  final int peopleCount;
  final DateTime dateTime;
  final String uid;
  final bool isPaid;
  final double price;
  final String? img;
  String? docId;

  EventData({
    this.docId,
    required this.uid,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.peopleCount,
    required this.description,
    required this.price,
    required this.isPaid,
    required this.locationUrl,
    this.img,
  });

  factory EventData.form(Map<String, dynamic> json) {
    return EventData(
      docId: json[keyDocId],
      uid: json[keyUid],
      title: json[keyTitle],
      location: json[keyLocation],
      dateTime: DateTime.parse(json[keyDateTime]),
      peopleCount: json[keyPeopleCount],
      description: json[keyDescription],
      price: json[keyPrice],
      isPaid: json[keyIsPaid],
      locationUrl: json[keyLocationUrl],
      img: json[keyImg],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyDocId: docId,
      keyUid: uid,
      keyTitle: title,
      keyLocation: location,
      keyDateTime: dateTime.toString(),
      keyPeopleCount: peopleCount,
      keyDescription: description,
      keyIsPaid: isPaid,
      keyPrice: price,
      keyLocationUrl: locationUrl,
      keyImg: img,
    };
  }
}
