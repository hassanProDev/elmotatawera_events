class MessageModel {
  final String message;
  final DateTime dateTime;
  final String uid;
  final String docId;

  const MessageModel(
      {required this.dateTime,
      required this.docId,
      required this.uid,
      required this.message});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        dateTime: json["dateTime"],
        docId: json["docId"],
        uid: json["uid"],
        message: json["message"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "dateTime": dateTime,
      "uid": uid,
      "docId": docId
    };
  }
}
