import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/model/attendence_model.dart';

class AttendenceService {
  CollectionReference<AttendanceModel> getAttendenceColection() {
    var attend = FirebaseFirestore.instance
        .collection('attendence')
        .withConverter<AttendanceModel>(
          fromFirestore: (snapshot, _) =>
              AttendanceModel.fromJson(snapshot.data()!),
          toFirestore: (attendence, _) => attendence.toJson(),
        );
    return attend;
  }

  Future<void> addAttendence(AttendanceModel attendenceModel) async {
    var doc = await getAttendenceColection().doc();
    return doc.set(attendenceModel);
  }

  getAllAttendence(String eventDocId) async {
    var collection = await getAttendenceColection();
    collection
        .orderBy(AttendanceModel.keyDateTime,descending: true)
        .where(AttendanceModel.keyDocId, isEqualTo: eventDocId)
        .get();
  }
}