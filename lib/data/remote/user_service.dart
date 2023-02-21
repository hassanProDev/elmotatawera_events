import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/model/users_model.dart';
class UserService{

  CollectionReference<UsersModel> getUserColection(){
    var user=FirebaseFirestore.instance.collection('users').withConverter<UsersModel>(
      fromFirestore: (snapshot, _) => UsersModel.fromJson(snapshot.data()!),
      toFirestore: (users, _) => users.toJson(),
    );
    return user;
  }

  Future<void> addUser(UsersModel usersModel)async{
    var doc= await getUserColection().doc();
    return doc.set(usersModel);
  }

  getUser(String uid)async{
    var colection=await getUserColection();
    return colection.where('uid',isEqualTo: uid).snapshots();
  }

}