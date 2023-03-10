import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';

class EventService {
  CollectionReference<EventModel> getEventColection() {
    var event = FirebaseFirestore.instance
        .collection('events')
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toJson(),
        );
    return event;
  }

  Future<void> addEvent(EventModel eventModel) async {
    var doc = await getEventColection().doc();
    return doc.set(eventModel);
  }

  getAllEvents() async {
    var collection = await getEventColection();
    return collection
        .orderBy(EventModel.keyPublishDate, descending: true)
        .get();
  }

  getAllActiveEvents() async {
    var collection = await getEventColection();
    return collection
        .orderBy(EventModel.keyPublishDate, descending: true)
        .where(EventModel.keyisEventDone, isEqualTo: false)
        .get();
  }

  getAllUnActiveEvents() async {
    var collection = await getEventColection();
    return collection
        .orderBy(EventModel.keyPublishDate, descending: true)
        .where(EventModel.keyisEventDone, isEqualTo: true)
        .get();
  }

  deleteEvent(EventModel eventModel) async {
    var collection = await getEventColection();
    return collection.doc(eventModel.eventData.docId).delete();
  }

  updateEvent(EventModel eventModel) async {
    var collection = await getEventColection();
    return collection.doc(eventModel.eventData.docId).update(eventModel.toJson());
  }
}
