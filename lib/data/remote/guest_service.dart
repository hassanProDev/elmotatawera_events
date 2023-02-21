

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';

class GuestService{
  CollectionReference<GuestModel> getGuestColection(){
    var guest=FirebaseFirestore.instance.collection('attendence').withConverter<GuestModel>(
      fromFirestore: (snapshot, _) => GuestModel.fromJson(snapshot.data()!),
      toFirestore: (guest, _) => guest.toJson(),
    );
    return guest;
  }

  Future<void> addGuest(GuestModel guestModel)async{
    var doc= await getGuestColection().doc();
    return doc.set(guestModel);
  }
}