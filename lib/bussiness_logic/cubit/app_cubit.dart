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
import 'package:elmotatawera_events/presentation/wigets/core/widgets/mix.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> with FirstGenerate {
  AppCubit() : super(AppInitial());

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
  var loginFormKey = GlobalKey<FormState>(debugLabel: 'GlobalFormKey #login ');

  var signUpEmail = TextEditingController();
  var signUpPassword = TextEditingController();
  var signUpConfirmPassword = TextEditingController();
  var signUpFirstName = TextEditingController();
  var signUpLastName = TextEditingController();
  var signUpPhone = TextEditingController();
  var signUpFormKey = GlobalKey<FormState>(debugLabel: 'GlobalFormKey #sginUp ');

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

  userSignUp(String email, String password,UserModel userModel) async {
    emit(SignUpLoading());
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userModel.uid=userCredential!.user!.uid;
      await addUser(userModel);
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
      await autoLogin(email, password);
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

  autoLogin(String email, String password)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    try {
      await prefs.setString("email",email);
      await prefs.setString("password",password);
      emit(AutoLoginSuccess());
    } on Exception catch (e) {
      print(e.toString());
      emit(AutoLoginFailer(errorMessage: e.toString()));
    }
  }

  Color cbt = ColorManager.redColor;

  ux() async {
    await FirebaseFirestore.instance
        .collection(kAppSetting)
        .doc(appSettingKey)
        .update({"hasSetting": hasSetting ? false : true});
    hasSetting ? cbt = ColorManager.redColor : cbt = ColorManager.blueColor;
    emit(AppInitial());
  }

  double drawerValue = 0;

  openDrawer() {
    drawerValue == 0 ? drawerValue = 1 : drawerValue = 0;
    emit(NavigateDrawer());
  }

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
          .then((value) async {
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

  List<UserModel> getAllActiveUsersList=[];

  getAllActiveUsers() {
    emit(UserLoading());
    try {
      user.where(UserModel.keyisBanded,isEqualTo: false).snapshots().listen((event) {
        getAllActiveUsersList = event.docs.map((e) => e.data()).toList();
      });
      emit(GetAllUsersSuccess());
    } on Exception catch (e) {
      emit(GetUserFailer(errorMessage: e.toString()));
    }
  }
  List<UserModel> getAllBandedUsersList=[];

  getAllBandedUsers() {
    emit(UserLoading());
    try {
      user.where(UserModel.keyisBanded,isEqualTo: true).snapshots().listen((event) {
        getAllBandedUsersList = event.docs.map((e) => e.data()).toList();
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
  banUser(UserModel userModel) async {
    try {
      String userType=userModel.userData.userType;
      userModel.userData.userType=userModel.userData.email;
      userModel.userData.email=userType;
      userModel.isBanded= !userModel.isBanded;
      await user.doc(userModel.userData.id).update(userModel.toJson());
      emit(UpdateUserDataSuccess());
    } on Exception catch (e) {
      emit(UpdateUserDataFailer(errorMessage: e.toString()));
    }
  }
  UserModel? selectedUaer;
  getSelectedUser(UserModel userModel){
    selectedUaer=userModel;
    emit(AppInitial());
  }

  int guestTabIndex = 0;

  changeGuestTabIndex(int index) {
    guestTabIndex = index;
    emit(ChangeTabIndex());
  }

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

  var eventFormKey = GlobalKey<FormState>(debugLabel: 'GlobalFormKey #event ');
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var locationController = TextEditingController();
  var locationUrlController = TextEditingController();
  var peopleCountController = TextEditingController();
  var maxAttendanceCountController = TextEditingController();
  var priceController = TextEditingController();

  resetEventController() {
    maxAttendanceCountController.clear();
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
  bool hasSetting = true;

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
        FirebaseFirestore.instance
            .collection(kAppSetting)
            .snapshots()
            .listen((value) {
          hasSetting = value.docs.first.data()["hasSetting"];
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
          .where(EventModel.keyIsEventDone, isEqualTo: false)
          .snapshots()
          .listen((event) {
        allActiveEvent = event.docs.map((e) => e.data()).toList();
        emit(GetAllActiveEventsSuccess(events: allActiveEvent ?? []));
      });
    } on Exception catch (e) {
      emit(GetAllActiveEventsFailer(errorMessage: e.toString()));
    }
  }
  var appCollection = FirebaseFirestore.instance.collection(kAppSetting);
  Map<String, dynamic> appSetting = {};

  getData() {
     appCollection.doc(appSettingKey).snapshots().listen((value) {
        appSetting=value.data()! ;
        checkAppState();
        if(appSetting["firstGenerate"]){
          firstGenerate();
          appCollection.doc(appSettingKey).update({"firstGenerate":false});
          updateChatState(true);
          updateSignUpState(true);
          updateSetting(true);
        }
      emit(AppSetting());
    });
  }

  updateChatState(bool chatStat) {
    appCollection.doc(appSettingKey).update({kIsChatForAll: chatStat});
  }
  updateSignUpState(bool signUpStat) {
    appCollection.doc(appSettingKey).update({kCanSignUp: signUpStat});
  }

  List<EventModel> allUnActiveEvent = [];

  getAllUnActiveEvents() async {
    emit(EventLoading());
    try {
      event
          .orderBy(EventModel.keyPublishDate, descending: true)
          .where(EventModel.keyIsEventDone, isEqualTo: true)
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

  var oldPassword=TextEditingController();
  var newPassword=TextEditingController();
  var confirmNewPassword=TextEditingController();
  var changePasswordFormKey = GlobalKey<FormState>(debugLabel: 'GlobalFormKey #changePassword ');


  resetChangePasswordField(){
    oldPassword.clear();
    newPassword.clear();
    confirmNewPassword.clear();
    emit(ClearController());
  }

  changePassword(String email,String oldPassword,String newPassword)async{
    var cred=EmailAuthProvider.credential(email: email, password: oldPassword);
    await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(cred).then((value) {
      FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
    }).catchError((onError){
      print(onError.toString());
    });
  }

  getUpdateEventData() {
    selectedEventModel!.eventData.dateTime =
        eventDateTime ?? selectedEventModel!.eventData.dateTime;
    selectedEventModel!.eventData.title = titleController.text.isEmpty
        ? selectedEventModel!.eventData.title
        : titleController.text;
    selectedEventModel!.eventData.description =
        descriptionController.text.isEmpty
            ? selectedEventModel!.eventData.description
            : descriptionController.text;
    selectedEventModel!.eventData.location = locationController.text.isEmpty
        ? selectedEventModel!.eventData.location
        : locationController.text;
    selectedEventModel!.eventData.locationUrl =
        locationUrlController.text.isEmpty
            ? selectedEventModel!.eventData.locationUrl
            : locationUrlController.text;
    selectedEventModel!.eventData.price = double.parse(
        priceController.text.isEmpty
            ? selectedEventModel!.eventData.price.toString()
            : priceController.text);
    selectedEventModel!.eventData.maxGuest = int.parse(
        maxAttendanceCountController.text.isEmpty
            ? selectedEventModel!.eventData.maxGuest.toString()
            : maxAttendanceCountController.text);
    selectedEventModel!.eventData.peopleCount = int.parse(
        peopleCountController.text.isEmpty
            ? selectedEventModel!.eventData.peopleCount.toString()
            : peopleCountController.text);
    emit(GetDataToUpdateScreen());
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

  var attend = FirebaseFirestore.instance
      .collection(kAttendance)
      .withConverter<AttendanceModel>(
        fromFirestore: (snapshot, _) =>
            AttendanceModel.fromJson(snapshot.data()!),
        toFirestore: (attendance, _) => attendance.toJson(),
      );

  Future<void> addAttendance(AttendanceModel attendenceModel,GuestModel guestModel) async {
    var doc = attend.doc();
    attendenceModel.attendanceData.attendId = doc.id;
    try {
      await doc.set(attendenceModel);
      guestModel.guestData.attendanceId=doc.id;
      updateGuestData(guestModel);
      emit(AddAttendanceSuccess());
    } on Exception catch (e) {
      // TODO
      emit(AddAttendanceFailer(errorMessage: e.toString()));
    }
  }
  checkAppState() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        updateFirstGenerate(true);
      }
    }
  }

  List<AttendanceModel> allAttendance = [];

  getAllAttendance(String eventDocId) async {
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

  updateAttendanceData(AttendanceModel attendanceModel) async {
    try {
      await guest
          .doc(attendanceModel.attendanceData.attendId)
          .update(attendanceModel.toJson());
      emit(UpdateAttendanceDataSuccess());
    } on Exception catch (e) {
      emit(UpdateAttendanceDataFailer(errorMessage: e.toString()));
    }
  }
  getUpdateDataForAttendance(GuestModel guestModel,String attendanceWith)async{
    AttendanceModel? attendanceModel;
    attendanceModel!.attendanceData.invitationCount=guestModel.guestData.peopleCount;
    attendanceModel.attendanceData.firstName=guestModel.guestData.firstName;
    attendanceModel.attendanceData.lastName=guestModel.guestData.lastName;
    attendanceModel.attendanceData.title=guestModel.guestData.titleEvent;
    attendanceModel.attendanceData.attendId=guestModel.guestData.attendanceId;
    attendanceModel.attendanceData.attendanceCount=guestModel.guestData.peopleCount-guestModel.guestData.availableInvite;
    attendanceModel.attendanceData.attendedWithId=attendanceWith;
    attendanceModel.attendanceData.uid=guestModel.uid;
    attendanceModel.docId=guestModel.docId;
    print(attendanceModel.attendanceData.attendanceCount);
    print(attendanceModel.attendanceData.invitationCount);
    await updateAttendanceData(attendanceModel);
  }


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

  var guestKeyForm = GlobalKey<FormState>(debugLabel: 'GlobalFormKey #guest ');

  Future<void> addGuest(GuestModel guestModel) async {
    try {
      var doc = guest.doc();
      guestModel.gid = doc.id;
      await doc.set(guestModel);
      emit(GuestAddedSuccess());
    } on Exception catch (e) {
      emit(GuestAddedFailer(errorMessage: e.toString()));
    }
  }

  int guestCount = 1;

  incrementGuestCounter() {
    guestCount++;
    emit(GuestCounter());
  }

  decrementGuestCounter() {
    guestCount--;
    emit(GuestCounter());
  }

  updateSetting(bool setting){
    appCollection.doc(appSettingKey).update({"hasSetting": setting});
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

  updateFirstGenerate(bool firstGenerate) {
    appCollection.doc(appSettingKey).update({"firstGenerate": firstGenerate});
  }


  List<GuestModel> getMyInvitationData = [];

  getMyInvitation(String uid) async {
    try {
      guest
          .orderBy(GuestModel.keyRegistrationDate, descending: true)
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
          .where(GuestModel.keyGid, isEqualTo: guestModel.gid)
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
      await guest.doc(guestModel.gid).delete();
      emit(DeleteGuestSuccess());
    } on Exception catch (e) {
      emit(DeleteGuestFailer(errorMessage: e.toString()));
    }
  }

  updateGuestData(GuestModel guestModel) async {
    try {
      await guest.doc(guestModel.gid).update(guestModel.toJson());
      emit(UpdateGuestDataSuccess());
    } on Exception catch (e) {
      emit(UpdateGuestDataFailer(errorMessage: e.toString()));
    }
  }

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

  int usersTabIndex=0;
  changeUsersTabIndex(int index){
    usersTabIndex=index;
    emit(AppInitial());
  }

  init() async {
    if (getUserData!.userData.userType == RouteNameManager.homeGuestScreen) {
      getMyInvitation(getUserData!.uid);
    }
  }
}