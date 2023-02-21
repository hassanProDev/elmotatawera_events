import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

///TODO: Don't forget your truth
  // double value=0;
  // bool dontTrickMe=true;
  // openDrawer(){
  //   value==0?value=1:value=0;
  //   emit(AppInitial());
  // }
  //
  // myTruth(){
  //   dontTrickMe?dontTrickMe=false:dontTrickMe=true;
  //   emit(AppInitial());
  // }


  IconData loginPasswordIcon=Icons.visibility;
  bool loginPasswordVisibilty=true;
  changeLoginPasswordVisibilty(){
    loginPasswordVisibilty= !loginPasswordVisibilty;
    loginPasswordVisibilty?loginPasswordIcon=Icons.visibility:loginPasswordIcon=Icons.visibility_off;
    emit(PasswordVisibilty());
  }

  IconData signUpPasswordIcon=Icons.visibility;
  bool signUpPasswordVisibilty=true;
  changeSignUpPasswordVisibilty(){
    signUpPasswordVisibilty= !signUpPasswordVisibilty;
    signUpPasswordVisibilty?signUpPasswordIcon=Icons.visibility:signUpPasswordIcon=Icons.visibility_off;
    emit(PasswordVisibilty());
  }

}
