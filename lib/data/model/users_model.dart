class UsersModel {
  
  static String keyFirstName="firstName";
  static String keyLastName="lastName";
  static String keyUid="uid";
  static String keyPhone="phone";
  static String keyUserType="userType";
  
  final String firstName;
  final String lastName;
  final String uid;
  final String phone;
  final String userType;

  const UsersModel(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.userType});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
        uid: json[keyUid],
        firstName: json[keyFirstName],
        lastName: json[keyLastName],
        phone: json[keyPhone],
        userType: json[keyUserType]);
  }

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyFirstName: firstName,
      keyLastName: lastName,
      keyPhone: phone,
      keyUserType: userType
    };
  }
}
