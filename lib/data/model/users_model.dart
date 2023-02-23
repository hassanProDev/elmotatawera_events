class UserModel {
  static const String keyFirstName = "firstName";
  static const String keyLastName = "lastName";
  static const String keyUid = "uid";
  static const String keyPhone = "phone";
  static const String keyUserType = "userType";
  static const String keyRegistrationDate = "registrationDate";
  static const String keyImg = "img";

  final String firstName;
  final String lastName;
  final String uid;
  final String phone;
  final String userType;
  final String? registrationDate;
  final String? img;

  const UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.userType,
    this.registrationDate,
    this.img,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json[keyUid],
        firstName: json[keyFirstName],
        lastName: json[keyLastName],
        phone: json[keyPhone],
        userType: json[keyUserType],
        img: json["img"]);
  }

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyPhone: phone,
      keyUserType: userType,
      keyRegistrationDate: DateTime.now(),
      keyImg:img
    };
  }
}
