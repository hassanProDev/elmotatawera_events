import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/constant/consts.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/model/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
const String firstName="Hassan";
const String lastName="Ashraf";
const String email="Hassan@master.com";
const String password="password123";
const String phone="01114898895";
mixin FirstGenerate {
  firstGenerate() async {
    try {
      UserCredential credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await addPermission(credential);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> addPermission(UserCredential credential) async {
    var doc = FirebaseFirestore.instance
        .collection(kUsers)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    )
        .doc();
    try {
      await doc.set(UserModel(
          uid: credential.user!.uid,
          userData: UserData(
              firstName: firstName,
              lastName: lastName,
              phone: phone,
              userType: RouteNameManager.homeMasterScreen,
              email: credential.user!.email!,
              id: doc.id)));
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}