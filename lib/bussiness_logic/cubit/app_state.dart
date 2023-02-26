part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class NavigateDrawer extends AppState {}

class PasswordVisibilty extends AppState {}

class SignUpLoading extends AppState {}

class SignUpSuccess extends AppState {}

class SignUpFailer extends AppState {
  String errorMessage;

  SignUpFailer({required this.errorMessage});
}

class LoginLoading extends AppState {}

class LoginSuccess extends AppState {}

class LoginFailer extends AppState {
  String errorMessage;

  LoginFailer({required this.errorMessage});
}

class UserLoading extends AppState {}

class UserAddedSuccess extends AppState {}

class UserAddedFailer extends AppState {
  String errorMessage;

  UserAddedFailer({required this.errorMessage});
}

class GetUserSuccess extends AppState {}

class GetUserFailer extends AppState {
  String errorMessage;

  GetUserFailer({required this.errorMessage});
}

class GetAllUsersSuccess extends AppState {}

class GetAllUsersFailer extends AppState {
  String errorMessage;

  GetAllUsersFailer({required this.errorMessage});
}

class DeleteUserSuccess extends AppState {}

class DeleteUserFailer extends AppState {
  String errorMessage;

  DeleteUserFailer({required this.errorMessage});
}

class UpdateUserDataSuccess extends AppState {}

class UpdateUserDataFailer extends AppState {
  String errorMessage;

  UpdateUserDataFailer({required this.errorMessage});
}

class EventLoading extends AppState {}

class EventAddedSuccess extends AppState {}

class EventAddedFailer extends AppState {
  String errorMessage;

  EventAddedFailer({required this.errorMessage});
}

class GetSelectedEventSuccess extends AppState {}

class GetAllEventsSuccess extends AppState {
  List<EventModel> events = [];

  GetAllEventsSuccess({required this.events});
}

class GetAllEventsFailer extends AppState {
  String errorMessage;

  GetAllEventsFailer({required this.errorMessage});
}

class GetAllActiveEventsSuccess extends AppState {
  List<EventModel> events = [];

  GetAllActiveEventsSuccess({required this.events});
}

class GetAllActiveEventsFailer extends AppState {
  String errorMessage;

  GetAllActiveEventsFailer({required this.errorMessage});
}

class GetAllUnActiveEventsSuccess extends AppState {
  List<EventModel> events = [];

  GetAllUnActiveEventsSuccess({required this.events});
}

class GetAllUnActiveEventsFailer extends AppState {
  String errorMessage;

  GetAllUnActiveEventsFailer({required this.errorMessage});
}

class DeleteEventSuccess extends AppState {}

class DeleteEventFailer extends AppState {
  String errorMessage;

  DeleteEventFailer({required this.errorMessage});
}

class UpdateEventDataSuccess extends AppState {}

class UpdateEventDataFailer extends AppState {
  String errorMessage;

  UpdateEventDataFailer({required this.errorMessage});
}

class ChangeTabIndex extends AppState {}
