class EventModel {
  static String keyTitle="title";
  static String keyUid="uid";
  static String keyDescription="description";
  static String keyLocation="location";
  static String keyLocationUrl="locationUrl";
  static String keyPeopleCount="peopleCount";
  static String keyDateTime="dateTime";
  static String keyDocId="docId";
  static String keyIsPaid="isPaid";
  static String keyPrice="price";

  final String title;
  final String description;
  final String location;
  final String locationUrl;
  final int peopleCount;
  final DateTime dateTime;
  final String uid;
  final String docId;
  final bool isPaid;
  final double price;

  const EventModel(
      {required this.uid,
      required this.docId,
      required this.title,
      required this.location,
      required this.dateTime,
      required this.peopleCount,
      required this.description,
      required this.price,
      required this.isPaid,
      required this.locationUrl});
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        uid: json[keyUid],
        title: json[keyTitle],
        location: json[keyLocation],
        dateTime: json[keyDateTime],
        peopleCount: json[keyPeopleCount],
        docId:json[keyDocId],
        description:json[keyDescription],
        price:json[keyPrice],
        isPaid:json[keyIsPaid],
        locationUrl:json[keyLocationUrl]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyTitle: title,
      keyLocation: location,
      keyDateTime: dateTime,
      keyPeopleCount: peopleCount,
      keyDocId:docId,
      keyDescription:description,
      keyIsPaid:isPaid,
      keyPrice:price,
      keyLocationUrl:locationUrl
    };
  }

}
