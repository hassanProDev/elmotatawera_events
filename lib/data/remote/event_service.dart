import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';

class EventService{
  CollectionReference<EventModel> getEventColection(){
    var event=FirebaseFirestore.instance.collection('attendence').withConverter<EventModel>(
      fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
      toFirestore: (event, _) => event.toJson(),
    );
    return event;
  }

  Future<void> addEvent(EventModel eventModel)async{
    var doc= await getEventColection().doc();
    return doc.set(eventModel);
  }
}