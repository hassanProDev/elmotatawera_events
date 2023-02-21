class AttendenceModel {
  final DateTime dateTime;
  final String firstName;
  final String lastName;
  final String uid;
  final String docId;
  final String title;

  const AttendenceModel(
      {required this.title,
      required this.firstName,
      required this.lastName,
      required this.dateTime,
      required this.uid,
      required this.docId});
  factory AttendenceModel.fromJson(Map<String, dynamic> json) {
    return AttendenceModel(
        uid: json["uid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        title: json["title"],
        dateTime: json["dateTime"],
        docId:json["docId"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "title": title,
      "dateTime": dateTime,
      "docId":docId
    };
  }

}
