class EventModel {
  final String title;
  final String description;
  final String location;
  final int peopleCount;
  final DateTime dateTime;
  final String uid;
  final String docId;

  const EventModel(
      {required this.uid,
      required this.docId,
      required this.title,
      required this.location,
      required this.dateTime,
      required this.peopleCount,
      required this.description});
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        uid: json["uid"],
        title: json["title"],
        location: json["location"],
        dateTime: json["dateTime"],
        peopleCount: json["peopleCount"],
        docId:json["docId"],
        description:json["description"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "title": title,
      "location": location,
      "dateTime": dateTime,
      "peopleCount": peopleCount,
      "docId":docId,
      "description":description
    };
  }

}
