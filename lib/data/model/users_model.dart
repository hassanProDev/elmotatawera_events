class UserModel {
  static const String keyFirstName = "firstName";
  static const String keyLastName = "lastName";
  static const String keyUid = "uid";
  static const String keyPhone = "phone";
  static const String keyUserType = "userType";
  static const String keyRegistrationDate = "registrationDate";
  static const String keyImg = "img";
  static const String keyEmail = "email";

  final String firstName;
  final String lastName;
  final String uid;
  final String phone;
  final String userType;
  final String? registrationDate;
  final String? img;
  final String? email;

  const UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.userType,
    this.registrationDate,
    this.img,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json[keyEmail],
        uid: json[keyUid],
        firstName: json[keyFirstName],
        lastName: json[keyLastName],
        phone: json[keyPhone],
        userType: json[keyUserType],
        img: json[keyImg]);
  }

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyPhone: phone,
      keyUserType: userType,
      keyRegistrationDate: DateTime.now(),
      keyImg: img,
      keyEmail: email,
    };
  }
}
