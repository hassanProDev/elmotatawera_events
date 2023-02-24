import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/constant/consts.dart';
import 'package:elmotatawera_events/data/model/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  ///TODO: Don't forget your truth

  // bool dontTrickMe=true;
  //
  // myTruth(){
  //   dontTrickMe?dontTrickMe=false:dontTrickMe=true;
  //   emit(AppInitial());
  // }

  // Registration Cubit
  IconData loginPasswordIcon = Icons.visibility;
  bool loginPasswordVisibilty = true;

  changeLoginPasswordVisibilty() {
    loginPasswordVisibilty = !loginPasswordVisibilty;
    loginPasswordVisibilty
        ? loginPasswordIcon = Icons.visibility
        : loginPasswordIcon = Icons.visibility_off;
    emit(PasswordVisibilty());
  }

  IconData signUpPasswordIcon = Icons.visibility;
  bool signUpPasswordVisibilty = true;

  changeSignUpPasswordVisibilty() {
    signUpPasswordVisibilty = !signUpPasswordVisibilty;
    signUpPasswordVisibilty
        ? signUpPasswordIcon = Icons.visibility
        : signUpPasswordIcon = Icons.visibility_off;
    emit(PasswordVisibilty());
  }

  UserCredential? userCredential;

  userSignUp(String email, String password) async {
    emit(SignUpLoading());
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential = credential;
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailer(errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailer(
            errorMessage: 'The account already exists for that email.'));
      }
    } on Exception catch (e) {
      emit(SignUpFailer(errorMessage: "some thing want wrong !!"));
    }
  }

  userLogin(String email, String password) async {
    emit(LoginLoading());
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential = credential;
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailer(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailer(
            errorMessage: 'Wrong password provided for that user.'));
      }
    } on Exception catch (e) {
      emit(LoginFailer(errorMessage: "some thing want wrong !!"));
    }
  }

  // late String userType;
  //
  // getUserType(String userType) {
  //   this.userType = userType;
  // }

  double value = 0;

  openDrawer() {
    value == 0 ? value = 1 : value = 0;
    emit(NavigateDrawer());
  }

// user cubit

  var user = FirebaseFirestore.instance
      .collection(kUsers)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Future<void> addUser(UserModel userModel) async {
    try {
      var doc = await user.doc();
       doc.set(userModel);
       emit(UserAddedSuccess());
    } on Exception catch (e) {
      emit(UserAddedFailer(errorMessage: e.toString()));
    }
  }

  UserModel? getUserData;
  getUser(String uid) async {
    try {
      await user.where(UserModel.keyUid,isEqualTo: uid).get().then((value) {
        getUserData=value.docs.map((e) => e.data()).toList()[0];
        print(" userrr ${getUserData!.userType}");

      });
      emit(GetUserSuccess());
      return getUserData;
    } on Exception catch (e) {
      emit(GetUserFailer(errorMessage: e.toString()));
    }
  }

  List<UserModel>? getAllUsersList;
  getAllUsers() async {
    try {
      await user.snapshots().listen((event) {
        getAllUsersList=event.docs.map((e) => e.data()).toList()??[];
      });
      emit(GetAllUsersSuccess());
    } on Exception catch (e) {
      emit(GetUserFailer(errorMessage: e.toString()));
    }
  }

  deleteUser(UserModel userModel) async {
    try {
      await user.doc(userModel.uid).delete();
      emit(DeleteUserSuccess());
    } on Exception catch (e) {
      emit(DeleteUserFailer(errorMessage: e.toString()));
    }
  }

  updateUserData(UserModel userModel) async {
     try {
       await user.doc(userModel.uid).update(userModel.toJson());
       emit(UpdateUserDataSuccess());
     } on Exception catch (e) {
       emit(UpdateUserDataFailer(errorMessage: e.toString()));
     }
  }




  init()async{
    await getAllUsers();
  }
}
