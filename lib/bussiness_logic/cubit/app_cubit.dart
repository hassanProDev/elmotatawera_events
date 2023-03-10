import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/consts.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/model/attendence_model.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:elmotatawera_events/data/model/message_model.dart';
import 'package:elmotatawera_events/data/model/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

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

  var loginEmail = TextEditingController();
  var loginPassword = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();

  var signUpEmail = TextEditingController();
  var signUpPassword = TextEditingController();
  var signUpConfirmPassword = TextEditingController();
  var signUpFirstName = TextEditingController();
  var signUpLastName = TextEditingController();
  var signUpPhone = TextEditingController();
  var signUpFormKey = GlobalKey<FormState>();

  IconData signUpPasswordIcon = Icons.visibility;
  bool signUpPasswordVisibilty = true;

  clearSignUpController() {
    signUpEmail.clear();
    signUpPassword.clear();
    signUpConfirmPassword.clear();
    signUpFirstName.clear();
    signUpLastName.clear();
    signUpPhone.clear();
    emit(ClearController());
  }

  clearLoginController() {
    loginEmail.clear();
    loginPassword.clear();
    emit(ClearController());
  }

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
      await getUser(credential.user!.uid);
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

  Color cbt = ColorManager.redColor;

  ux() async {
    await FirebaseFirestore.instance
        .collection("x")
        .doc("qAphe7GD0eoN2oGQWnUW")
        .update({"x": x ? false : true});
    x ? cbt = ColorManager.redColor : cbt = ColorManager.blueColor;
    emit(AppInitial());
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
    var doc = user.doc();
    userModel.userData.id = doc.id;
    try {
      await doc.set(userModel);
      emit(UserAddedSuccess());
    } on Exception catch (e) {
      emit(UserAddedFailer(errorMessage: e.toString()));
    }
  }

  UserModel? getUserData;
  bool xbt = false;

  getUser(String uid) async {
    emit(UserLoading());
    try {
      await user
          .where(UserModel.keyUid, isEqualTo: uid)
          .limit(1)
          .get()
          .then((value) {
        getUserData = value.docs.first.data();
        xbt = value.docs.first.data().userData.userType ==
            RouteNameManager.homeMasterScreen;
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
      await user.doc(userModel.userData.id).delete();
      emit(DeleteUserSuccess());
    } on Exception catch (e) {
      emit(DeleteUserFailer(errorMessage: e.toString()));
    }
  }

  updateUserData(UserModel userModel) async {
    try {
      await user.doc(userModel.userData.id).update(userModel.toJson());
      emit(UpdateUserDataSuccess());
    } on Exception catch (e) {
      emit(UpdateUserDataFailer(errorMessage: e.toString()));
    }
  }

  int guestTabIndex = 0;

  changeGuestTabIndex(int index) {
    guestTabIndex = index;
    emit(ChangeTabIndex());
  }

// end user cubit

  // event cubit

  var event = FirebaseFirestore.instance
      .collection(kEvents)
      .withConverter<EventModel>(
        fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
        toFirestore: (event, _) => event.toJson(),
      );

  DateTime? eventDateTime;

  getSelectedDate(DateTime? dateTime) {
    eventDateTime = dateTime;
    emit(GetSelectedDate());
  }

  var eventFormKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var locationController = TextEditingController();
  var locationUrlController = TextEditingController();
  var peopleCountController = TextEditingController();
  var priceController = TextEditingController();

  resetEventController() {
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    locationUrlController.clear();
    peopleCountController.clear();
    priceController.clear();
    emit(AppInitial());
  }

  Future<void> addEvent(EventModel eventModel) async {
    try {
      var doc = event.doc();
      eventModel.eventData.docId = doc.id;
      await doc.set(eventModel);
      emit(EventAddedSuccess());
    } on Exception catch (e) {
      emit(EventAddedFailer(errorMessage: e.toString()));
    }
  }

  EventModel? selectedEventModel;

  getSelectedEventModel(EventModel eventModel) {
    selectedEventModel = eventModel;
    emit(GetSelectedEventSuccess());
  }

  List<EventModel> allEventList = [];
  bool x = true;

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
        FirebaseFirestore.instance.collection("x").snapshots().listen((value) {
          x = value.docs.first.data()["x"];
          emit(GetAllEventsSuccess(events: allEventList ?? []));
        });
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

        emit(GetAllUnActiveEventsSuccess(events: allUnActiveEvent ?? []));
      });
    } on Exception catch (e) {
      emit(GetAllUnActiveEventsFailer(errorMessage: e.toString()));
    }
  }

  deleteEvent(EventModel eventModel) async {
    try {
      await event.doc(eventModel.eventData.docId).delete();
      emit(DeleteEventSuccess());
    } on Exception catch (e) {
      emit(DeleteEventFailer(errorMessage: e.toString()));
    }
  }

  updateEvent(EventModel eventModel) async {
    try {
      await event.doc(eventModel.eventData.docId).update(eventModel.toJson());
      emit(UpdateEventDataSuccess());
    } on Exception catch (e) {
      emit(UpdateEventDataFailer(errorMessage: e.toString()));
    }
  }

  int currentTabIndex = 0;

  changeTabIndex(int index) {
    currentTabIndex = index;
    emit(ChangeTabIndex());
  }

  int eventBottomNavIndex = 0;

  changeEventBottomNavIndex(int index) {
    eventBottomNavIndex = index;
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
    try {
      await attend.doc().set(attendenceModel);
      emit(AddAttendanceSuccess());
    } on Exception catch (e) {
      // TODO
      emit(AddAttendanceFailer(errorMessage: e.toString()));
    }
  }

  List<AttendanceModel> allAttendance = [];

  getAllAttendence(String eventDocId) async {
    try {
      attend
          .orderBy(AttendanceModel.keyDateTime, descending: true)
          .where(AttendanceModel.keyDocId, isEqualTo: eventDocId)
          .snapshots()
          .listen((event) {
        allAttendance = event.docs.map((e) => e.data()).toList();
        emit(GetAllAttendanceSuccess());
      });
    } on Exception catch (e) {
      emit(GetAllAttendanceFailer(errorMessage: e.toString()));
    }
  }

  // end attendance cubit

  // guest cubit

  var guestFirstName = TextEditingController();
  var guestLastName = TextEditingController();
  var guestPeopleCount = TextEditingController();
  var guestPhone = TextEditingController();

  resetGuestController() {
    guestLastName.clear();
    guestFirstName.clear();
    guestPeopleCount.clear();
    guestPhone.clear();
    emit(AppInitial());
  }

  var guest = FirebaseFirestore.instance
      .collection(kGuests)
      .withConverter<GuestModel>(
        fromFirestore: (snapshot, _) => GuestModel.fromJson(snapshot.data()!),
        toFirestore: (guest, _) => guest.toJson(),
      );

  var guestKeyForm = GlobalKey<FormState>();

  Future<void> addGuest(GuestModel guestModel) async {
    try {
      var doc = guest.doc();
      guestModel.guestData.gid = doc.id;
      await doc.set(guestModel);
      emit(GuestAddedSuccess());
    } on Exception catch (e) {
      emit(GuestAddedFailer(errorMessage: e.toString()));
    }
  }

  List<GuestModel> getMyGuestsData = [];

  getMyGuests(String docId, String uid) async {
    try {
      guest
          .orderBy(GuestModel.keyRegistrationDate, descending: true)
          .where(GuestModel.keyDocId, isEqualTo: docId)
          .where(GuestModel.keyUid, isEqualTo: uid)
          .snapshots()
          .listen((event) {
        getMyGuestsData = event.docs.map((e) => e.data()).toList();
        emit(GetMyGuestsSuccess(guests: getMyGuestsData));
      });
    } on Exception catch (e) {
      emit(GetMyGuestsFailer(errorMessage: e.toString()));
    }
  }

  List<GuestModel> getMyInvitationData = [];

  getMyInvitation(String uid) async {
    try {
      guest
          .orderBy(GuestModel.keyRegistrationDate, descending: true)
          .where(GuestModel.keyIsConfirmed, isEqualTo: true)
          .where(GuestModel.keyUid, isEqualTo: uid)
          .snapshots()
          .listen((event) {
        getMyInvitationData = event.docs.map((e) => e.data()).toList();
        emit(GetMyInvitationSuccess(guests: getMyInvitationData));
      });
    } on Exception catch (e) {
      emit(GetMyInvitationFailer(errorMessage: e.toString()));
    }
  }

  GuestModel? qrSelectedInviteData;

  getSelectedQrInvition(GuestModel guestModel) {
    qrSelectedInviteData = guestModel;
    emit(AppInitial());
  }

  GuestModel? invitationData;

  checkInvitationData(GuestModel guestModel) async {
    try {
      await guest
          .where(GuestModel.keyIsConfirmed, isEqualTo: true)
          .where(GuestModel.keyUid, isEqualTo: guestModel.uid)
          .limit(1)
          .get()
          .then((value) {
        invitationData = value.docs.first.data();
        emit(CheckInvitationSuccess(guestModel: invitationData!));
      });
    } on Exception catch (e) {
      emit(CheckInvitationFailer(errorMessage: e.toString()));
    }
  }

  String qrCode = "";

  Future<void> scanQR() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.QR)
          .then((value) {
        qrCode = value;
        emit(ScanQrSuccess());
      });
    } on PlatformException {
      emit(ScanQrFailer(errorMessage: "Failed Invitation"));
    }
  }

  // scanQr(Barcode? result){
  //   if (result != null) {
  //     try {
  //       var guestModel =
  //       GuestModel.fromQrCode(jsonDecode(result.code!));
  //        checkInvitationData(guestModel);
  //       emit(ScanQrSuccess());
  //     } on Exception catch (e) {
  //       emit(SignUpFailer(errorMessage: e.toString()));
  //     }
  //
  //   }
  // }
  List<GuestModel> allConfirmedGuests = [];

  getConfirmedGuests(String eventDocId) async {
    try {
      guest
          .orderBy(GuestModel.keyRegistrationDate, descending: true)
          .where(GuestModel.keyIsConfirmed, isEqualTo: true)
          .where(GuestModel.keyDocId, isEqualTo: eventDocId)
          .snapshots()
          .listen((event) {
        allConfirmedGuests = event.docs.map((e) => e.data()).toList();
        emit(GetAllConfimedGuestsSuccess(guests: allConfirmedGuests));
      });
    } on Exception catch (e) {
      emit(GetAllConfimedGuestsFailer(errorMessage: e.toString()));
    }
  }

  List<GuestModel> allUnConfirmedGuests = [];

  getUnConfirmedGuests(String eventDocId) {
    try {
      guest
          .orderBy(GuestModel.keyRegistrationDate, descending: true)
          .where(GuestModel.keyIsConfirmed, isEqualTo: false)
          .where(GuestModel.keyDocId, isEqualTo: eventDocId)
          .snapshots()
          .listen((event) {
        allUnConfirmedGuests = event.docs.map((e) => e.data()).toList();
        emit(GetAllUnConfimedGuestsSuccess(guests: allUnConfirmedGuests));
      });
    } on Exception catch (e) {
      emit(GetAllUnConfimedGuestsFailer(errorMessage: e.toString()));
    }
  }

  deleteGuest(GuestModel guestModel) async {
    try {
      await guest.doc(guestModel.guestData.gid).delete();
      emit(DeleteGuestSuccess());
    } on Exception catch (e) {
      emit(DeleteGuestFailer(errorMessage: e.toString()));
    }
  }

  updateGuestData(GuestModel guestModel) async {
    try {
      await guest.doc(guestModel.guestData.gid).update(guestModel.toJson());
      emit(UpdateGuestDataSuccess());
    } on Exception catch (e) {
      emit(UpdateGuestDataFailer(errorMessage: e.toString()));
    }
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
    var doc = message.doc();
    try {
      messageModel.messageData.mid = doc.id;
      await doc.set(messageModel);
      emit(AddMessageSuccess());
    } on Exception catch (e) {
      emit(AddMessageFailer(errorMessage: e.toString()));
    }
  }

  List<MessageModel> allMessages = [];

  getAllMessage(String docId) {
    try {
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
          .listen((event) {
        allMessages = event.docs.map((e) => e.data()).toList();
        emit(GetAllMessagesSuccess(messages: allMessages ?? []));
      });
    } catch (e) {
      emit(GetAllMessagesFailer(errorMessage: e.toString()));
    }
  }

  // end message cubit

  init() async {
    await getAllUsers();
  }
}
