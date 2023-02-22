class GuestModel {

  static String keyFirstName="firstName";
  static String keyLastName="lastName";
  static String keyUid="uid";
  static String keyDocId="docId";
  static String keyPhone="phone";
  static String keyPeopleCount="peopleCount";
  static String keyIsConfirmed="isConfirmed";
  static String keyRegistrationDate="registrationDate";


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
      keyUid: uid,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyPhone: phone,
      keyPeopleCount: peopleCount,
      keyDocId: docId,
      keyIsConfirmed: isConfirmed,
      keyRegistrationDate: registrationDate
    };
  }
}
