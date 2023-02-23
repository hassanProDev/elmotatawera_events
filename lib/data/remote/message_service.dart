import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/model/message_model.dart';

class MessageService {
  CollectionReference<MessageModel> getMessageColection() {
    var attend = FirebaseFirestore.instance
        .collection('messages')
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, _) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (message, _) => message.toJson(),
        );
    return attend;
  }

  Future<void> addMessage(MessageModel messageModel) async {
    var doc = await getMessageColection().doc();
    return doc.set(messageModel);
  }

  getAllMessage(String docId) async {
    var collection = await getMessageColection();
    return collection
        .orderBy(
          MessageModel.keyDateTime,
          descending: true,
        )
        .where(
          MessageModel.keyDocId,
          isEqualTo: docId,
        )
        .get();
  }
}
