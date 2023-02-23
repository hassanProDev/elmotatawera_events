import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/model/users_model.dart';
class UserService{

  CollectionReference<UserModel> getUserColection(){
    var user=FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
    return user;
  }

  Future<void> addUser(UserModel userModel)async{
    var doc= await getUserColection().doc();
    return doc.set(userModel);
  }

  getUser(String uid)async{
    var colection=await getUserColection();
    return colection.where(UserModel.keyUid,isEqualTo: uid).get();
  }

  getAllUsers()async{
    var colection=await getUserColection();
    return colection.orderBy(UserModel).get();
  }

  deleteUser(UserModel userModel)async{
    var colection=await getUserColection();
    return colection.doc(userModel.uid).delete();
  }

  updateUserData(UserModel userModel)async{
    var colection=await getUserColection();
    return colection.doc(userModel.uid).update(userModel.toJson());
  }

}