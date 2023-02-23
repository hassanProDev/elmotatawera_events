import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';

class GuestService {
  CollectionReference<GuestModel> getGuestColection() {
    var guest = FirebaseFirestore.instance
        .collection('guests')
        .withConverter<GuestModel>(
          fromFirestore: (snapshot, _) => GuestModel.fromJson(snapshot.data()!),
          toFirestore: (guest, _) => guest.toJson(),
        );
    return guest;
  }

  Future<void> addGuest(GuestModel guestModel) async {
    var doc = await getGuestColection().doc();
    return doc.set(guestModel);
  }

  getAllGuests(String eventDocId) async {
    var collection = await getGuestColection();
    return collection
        .orderBy(GuestModel.keyRegistrationDate, descending: true)
        .where(GuestModel.keyDocId, isEqualTo: eventDocId)
        .get();
  }

  getConfirmedGuest(String eventDocId) async {
    var collection = await getGuestColection();
    return collection
        .orderBy(GuestModel.keyRegistrationDate, descending: true)
        .where(GuestModel.keyIsConfirmed, isEqualTo: true)
        .where(GuestModel.keyDocId, isEqualTo: eventDocId)
        .get();
  }

  getUnConfirmedGuest(String eventDocId) async {
    var collection = await getGuestColection();
    return collection
        .orderBy(GuestModel.keyRegistrationDate, descending: true)
        .where(GuestModel.keyIsConfirmed, isEqualTo: false)
        .where(GuestModel.keyDocId, isEqualTo: eventDocId)
        .get();
  }

  deleteGuest(GuestModel guestModel) async {
    var collection = await getGuestColection();
    return collection.doc(guestModel.gid).delete();
  }

  updateGuestData(GuestModel guestModel) async {
    var collection = await getGuestColection();
    return collection.doc(guestModel.gid).update(guestModel.toJson());
  }
}
