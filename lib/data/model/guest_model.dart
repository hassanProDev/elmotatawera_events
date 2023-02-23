class GuestModel {
  static const String keyFirstName = "firstName";
  static const String keyLastName = "lastName";
  static const String keyGid = "gid";
  static const String keyUid = "uid";
  static const String keyDocId = "docId";
  static const String keyPhone = "phone";
  static const String keyPeopleCount = "peopleCount";
  static const String keyIsConfirmed = "isConfirmed";
  static const String keyRegistrationDate = "registrationDate";

  final String firstName;
  final String lastName;
  final String? gid;
  final String uid;
  final String docId;
  final String phone;
  final int peopleCount;
  final bool isConfirmed;
  final DateTime? registrationDate;

  const GuestModel({
    this.gid,
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.peopleCount,
    required this.docId,
    required this.isConfirmed,
    this.registrationDate,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) {
    return GuestModel(
      gid: json[keyGid],
      uid: json[keyUid],
      firstName: json[keyFirstName],
      lastName: json[keyLastName],
      phone: json[keyPhone],
      peopleCount: json[keyPeopleCount],
      docId: json[keyDocId],
      isConfirmed: json[keyIsConfirmed],
      registrationDate: json[keyRegistrationDate],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyGid: uid + docId,
      keyUid: uid,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyPhone: phone,
      keyPeopleCount: peopleCount,
      keyDocId: docId,
      keyIsConfirmed: isConfirmed,
      keyRegistrationDate: DateTime.now()
    };
  }
}
