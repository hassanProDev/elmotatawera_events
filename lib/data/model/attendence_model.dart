class AttendenceModel {
  static String keyUid="uid";
  static String keyDateTime="dateTime";
  static String keyFirstName="firstName";
  static String keyLastName="lastName";
  static String keyTitle="title";
  static String keyDocId="docId";
  static String keyAttendedWithId="attendedWithId";

  final DateTime dateTime;
  final String firstName;
  final String lastName;
  final String uid;
  final String docId;
  final String title;
  final String attendedWithId;

  const AttendenceModel(
      {required this.title,
      required this.firstName,
      required this.lastName,
      required this.dateTime,
      required this.uid,
      required this.docId,required this.attendedWithId});
  factory AttendenceModel.fromJson(Map<String, dynamic> json) {
    return AttendenceModel(
        uid: json[keyUid],
        firstName: json[keyFirstName],
        lastName: json[keyLastName],
        title: json[keyTitle],
        dateTime: json[keyDateTime],
        docId:json[keyDocId],
        attendedWithId:json[keyAttendedWithId]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyTitle: title,
      keyDateTime: dateTime,
      keyDocId:docId,
      keyAttendedWithId:attendedWithId
    };
  }

}
