import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/constant/consts.dart';
import 'package:elmotatawera_events/data/model/attendence_model.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:elmotatawera_events/data/model/message_model.dart';
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

  var loginFormKey = GlobalKey<FormState>();
  var signUpFormKey = GlobalKey<FormState>();

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

  double drawerValue = 0;

  openDrawer() {
    drawerValue == 0 ? drawerValue = 1 : drawerValue = 0;
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
      await user.doc().set(userModel);
      emit(UserAddedSuccess());
    } on Exception catch (e) {
      emit(UserAddedFailer(errorMessage: e.toString()));
    }
  }

  UserModel? getUserData;

  getUser(String uid) async {
    emit(UserLoading());
    try {
      await user.where(UserModel.keyUid, isEqualTo: uid).get().then((value) {
        getUserData = value.docs.map((e) => e.data()).toList()[0];
        print(" userrr ${getUserData!.userType}");
      });
      emit(GetUserSuccess());
      return getUserData;
    } on Exception catch (e) {
      emit(GetUserFailer(errorMessage: e.toString()));
    }
  }

  List<UserModel>? getAllUsersList;

  getAllUsers() {
    emit(UserLoading());
    try {
      user.snapshots().listen((event) {
        getAllUsersList = event.docs.map((e) => e.data()).toList() ?? [];
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

// end user cubit

  // event cubit

  var event = FirebaseFirestore.instance
      .collection(kEvents)
      .withConverter<EventModel>(
        fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
        toFirestore: (event, _) => event.toJson(),
      );

  Future<void> addEvent(EventModel eventModel) async {
    try {
      var doc=event.doc();
      eventModel.docId=doc.id;
      await doc.set(eventModel);
      emit(EventAddedSuccess());
    } on Exception catch (e) {
      emit(EventAddedFailer(errorMessage: e.toString()));
    }
  }

  EventModel? selectedEventModel;
  getSelectedEventModel(EventModel eventModel){
    selectedEventModel=eventModel;
    emit(GetSelectedEventSuccess());
  }
  List<EventModel> allEventList = [];

  getAllEvents() {
    emit(EventLoading());
    try {
      event
          .orderBy(EventModel.keyPublishDate, descending: true)
          .snapshots()
          .listen((event) {
        allEventList.clear();
        event.docs.map((e) => e.data()).toList().forEach((element) {
          allEventList.add(element);
        });
        print("allEventList");
        print(allEventList);
        emit(GetAllEventsSuccess(events: allEventList ?? []));
      });
    } on Exception catch (e) {
      emit(GetAllEventsFailer(errorMessage: e.toString()));
    }
  }

  List<EventModel> allActiveEvent = [];

  getAllActiveEvents() async {
    emit(EventLoading());
    try {
      event
          .orderBy(EventModel.keyPublishDate, descending: true)
          .where(EventModel.keyisEventDone, isEqualTo: false)
          .snapshots()
          .listen((event) {
        allActiveEvent = event.docs.map((e) => e.data()).toList();
        print("allActiveEvent");
        print(allActiveEvent);
        emit(GetAllActiveEventsSuccess(events: allActiveEvent ?? []));
      });
    } on Exception catch (e) {
      emit(GetAllActiveEventsFailer(errorMessage: e.toString()));
    }
  }

  List<EventModel> allUnActiveEvent = [];

  getAllUnActiveEvents() async {
    emit(EventLoading());
    try {
      event
          .orderBy(EventModel.keyPublishDate, descending: true)
          .where(EventModel.keyisEventDone, isEqualTo: true)
          .snapshots()
          .listen((event) {
        allUnActiveEvent = event.docs.map((e) => e.data()).toList();
        print("allUnActiveEvent");
        print(allUnActiveEvent);
        emit(GetAllUnActiveEventsSuccess(events: allUnActiveEvent ?? []));
      });
    } on Exception catch (e) {
      emit(GetAllUnActiveEventsFailer(errorMessage: e.toString()));
    }
  }

  deleteEvent(EventModel eventModel) async {
    try {
      await event.doc(eventModel.docId).delete();
      emit(DeleteEventSuccess());
    } on Exception catch (e) {
      emit(DeleteEventFailer(errorMessage: e.toString()));
    }
  }

  updateEvent(EventModel eventModel) async {
    try {
      await event.doc(eventModel.docId).update(eventModel.toJson());
      emit(UpdateEventDataSuccess());
    } on Exception catch (e) {
      emit(UpdateEventDataFailer(errorMessage: e.toString()));
    }
  }

  int currentTabIndex = 0;

  changeTabIdex(int index) {
    currentTabIndex = index;
    emit(ChangeTabIndex());
  }

  // end event cubit

  // attendance cubit

  var attend = FirebaseFirestore.instance
      .collection(kAttendence)
      .withConverter<AttendanceModel>(
        fromFirestore: (snapshot, _) =>
            AttendanceModel.fromJson(snapshot.data()!),
        toFirestore: (attendance, _) => attendance.toJson(),
      );

  Future<void> addAttendance(AttendanceModel attendenceModel) async {
    await attend.doc().set(attendenceModel);
  }

  getAllAttendence(String eventDocId) async {
    attend
        .orderBy(AttendanceModel.keyDateTime, descending: true)
        .where(AttendanceModel.keyDocId, isEqualTo: eventDocId)
        .snapshots()
        .listen((event) {});
  }

  // end attendance cubit

  // guest cubit

  var guest = FirebaseFirestore.instance
      .collection(kGuests)
      .withConverter<GuestModel>(
        fromFirestore: (snapshot, _) => GuestModel.fromJson(snapshot.data()!),
        toFirestore: (guest, _) => guest.toJson(),
      );

  Future<void> addGuest(GuestModel guestModel) async {
    await guest.doc().set(guestModel);
  }

  getAllGuests(String eventDocId) async {
    guest
        .orderBy(GuestModel.keyRegistrationDate, descending: true)
        .where(GuestModel.keyDocId, isEqualTo: eventDocId)
        .snapshots()
        .listen((event) {});
  }

  getConfirmedGuests(String eventDocId) async {
    guest
        .orderBy(GuestModel.keyRegistrationDate, descending: true)
        .where(GuestModel.keyIsConfirmed, isEqualTo: true)
        .where(GuestModel.keyDocId, isEqualTo: eventDocId)
        .snapshots()
        .listen((event) {});
  }

  getUnConfirmedGuests(String eventDocId) {
    guest
        .orderBy(GuestModel.keyRegistrationDate, descending: true)
        .where(GuestModel.keyIsConfirmed, isEqualTo: false)
        .where(GuestModel.keyDocId, isEqualTo: eventDocId)
        .snapshots()
        .listen((event) {});
  }

  deleteGuest(GuestModel guestModel) async {
    await guest.doc(guestModel.gid).delete();
  }

  updateGuestData(GuestModel guestModel) async {
    await guest.doc(guestModel.gid).update(guestModel.toJson());
  }

  // end guest cubit

  // message cubit

  var message = FirebaseFirestore.instance
      .collection(kMessages)
      .withConverter<MessageModel>(
        fromFirestore: (snapshot, _) => MessageModel.fromJson(snapshot.data()!),
        toFirestore: (message, _) => message.toJson(),
      );

  Future<void> addMessage(MessageModel messageModel) async {
    await message.doc().set(messageModel);
  }

  getAllMessage(String docId) {
    message
        .orderBy(
          MessageModel.keyDateTime,
          descending: true,
        )
        .where(
          MessageModel.keyDocId,
          isEqualTo: docId,
        )
        .snapshots()
        .listen((event) {});
  }

  // end message cubit

  init() async {
    await getAllUsers();
  }
}
