class MessageModel {

  static String keyMessage="message";
  static String keyDateTime="dateTime";
  static String keyUid="uid";
  static String keyDocId="docId";

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
        dateTime: json[keyDateTime],
        docId: json[keyDocId],
        uid: json[keyUid],
        message: json[keyMessage]);
  }

  Map<String, dynamic> toJson() {
    return {
      keyMessage: message,
      keyDateTime: dateTime,
      keyDateTime: uid,
      keyDocId: docId
    };
  }
}
