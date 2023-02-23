class MessageModel {
  static const String keyMessage = "message";
  static const String keyDateTime = "dateTime";
  static const String keyUid = "uid";
  static const String keyDocId = "docId";

  final String message;
  final DateTime? dateTime;
  final String uid;
  final String docId;

  const MessageModel({
    this.dateTime,
    required this.docId,
    required this.uid,
    required this.message,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        dateTime: json[keyDateTime],
        docId: json[keyDocId],
        uid: json[keyUid],
        message: json[keyMessage]);
  }

  Map<String, dynamic> toJson() {
    return {
      keyMessage: message,
      keyDateTime: DateTime.now(),
      keyUid: uid,
      keyDocId: docId
    };
  }
}
