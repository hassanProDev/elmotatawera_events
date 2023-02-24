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
