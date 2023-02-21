class GuestModel {
  final String firstName;
  final String lastName;
  final String uid;
  final String docId;
  final String phone;
  final int peopleCount;
  final bool isConfirmed;
  final DateTime registrationDate;

  const GuestModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.peopleCount,
    required this.docId,
    required this.isConfirmed,
    required this.registrationDate,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) {
    return GuestModel(
      uid: json["uid"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      phone: json["phone"],
      peopleCount: json["peopleCount"],
      docId: json["docId"],
      isConfirmed: json["isConfirmed"],
      registrationDate: json["registrationDate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "peopleCount": peopleCount,
      "docId": docId,
      "isConfirmed": isConfirmed,
      "registrationDate": registrationDate
    };
  }
}
