


import 'package:firebase_auth/firebase_auth.dart';

class RegistrationService{

  userSignUp(String email,String password)async{
    UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

}