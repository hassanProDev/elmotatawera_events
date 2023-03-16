import 'dart:convert';

class UserModel {
  static const String keyUid = "uid";
  static const String keyUserData = "userData";
  static const String keyRegistrationDate = "registrationDate";

  final String uid;
  final UserData userData;
  final String? registrationDate;

  const UserModel({
    required this.uid,
    this.registrationDate,
    required this.userData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json[keyUid],
      userData: UserData.fromJson(jsonDecode(json[keyUserData])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyRegistrationDate: DateTime.now(),
      keyUserData: jsonEncode(userData.toJson()),
    };
  }
}

class UserData {
  static const String keyFirstName = "firstName";
  static const String keyLastName = "lastName";
  static const String keyPhone = "phone";
  static const String keyUserType = "userType";
  static const String keyImg = "img";
  static const String keyId = "id";
  static const String keyEmail = "email";

  final String firstName;
  final String lastName;
  final String? img;
   String email;
  final String phone;
   String userType;
  String? id;

   UserData({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.userType,
    this.img,
    this.id,
    required this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json[keyId],
        email: json[keyEmail],
        firstName: json[keyFirstName],
        lastName: json[keyLastName],
        phone: json[keyPhone],
        userType: json[keyUserType],
        img: json[keyImg]);
  }

  Map<String, dynamic> toJson() {
    return {
      keyId:id,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyPhone: phone,
      keyUserType: userType,
      keyImg: img,
      keyEmail: email,
    };
  }
}
