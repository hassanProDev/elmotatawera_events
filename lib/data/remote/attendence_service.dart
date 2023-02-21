

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/model/attendence_model.dart';

class AttendenceService{
  CollectionReference<AttendenceModel> getAttendenceColection(){
    var attend=FirebaseFirestore.instance.collection('attendence').withConverter<AttendenceModel>(
      fromFirestore: (snapshot, _) => AttendenceModel.fromJson(snapshot.data()!),
      toFirestore: (attendence, _) => attendence.toJson(),
    );
    return attend;
  }

  Future<void> addAttendence(AttendenceModel attendenceModel)async{
    var doc= await getAttendenceColection().doc();
    return doc.set(attendenceModel);
  }


}