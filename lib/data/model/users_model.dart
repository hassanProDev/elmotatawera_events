class UsersModel {
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
        uid: json["uid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        userType: json["userType"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "userType": userType
    };
  }
}
