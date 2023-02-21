import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/model/users_model.dart';
import 'package:elmotatawera_events/data/remote/registration_service.dart';
import 'package:elmotatawera_events/data/remote/user_service.dart';
import 'package:elmotatawera_events/presentation/screens/registration/widget/custom_textformfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/utils/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatelessWidget {
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? phone;
  UserCredential? credential;

  @override
  Widget build(BuildContext context) {
    // toast.init(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit myCubit=BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: GlobalRichText(
              firstString: "ElMotatawera",
              secondString: "Events",
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Form(
                child: Column(
                  children: [
                    GlobalRichText(
                      firstString: "ElMotatawera",
                      secondString: "Events",
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextFormField(
                      text: "first name",
                      onChange: (value) {
                        firstName = value;
                      },
                    ),
                    CustomTextFormField(
                      text: "last name",
                      onChange: (value) {
                        lastName = value;
                      },
                    ),
                    CustomTextFormField(
                      text: "phone",
                      onChange: (value) {
                        phone = value;
                      },
                    ),
                    CustomTextFormField(
                      text: "email",
                      onChange: (value) {
                        email = value;
                      },
                    ),
                    CustomTextFormField(
                      text: "password",
                      isPassword: myCubit.signUpPasswordVisibilty,
                      onChange: (value) {
                        password = value;
                      },
                      iconData:myCubit.signUpPasswordIcon ,
                      onClick:() {
                        myCubit.changeSignUpPasswordVisibilty();
                      },
                    ),
                    CustomTextFormField(
                      text: "confirm-password",
                      iconData:myCubit.signUpPasswordIcon ,
                      isPassword: myCubit.signUpPasswordVisibilty,
                      onClick:() {
                        myCubit.changeSignUpPasswordVisibilty();
                      },
                    ),
                    CustomButton(
                      text: "Sign Up",
                      color: Colors.red,
                      onTap: () async {
                        try {
                          credential =
                          await RegistrationService().userSignUp(email!, password!);
                          await UserService().addUser(UsersModel(
                              uid: credential!.user!.uid,
                              firstName: firstName!,
                              lastName: lastName!,
                              phone: phone!,
                              userType: "guest"));
                          // toast.showToast(child: CustomToast(text: 'registration is success',));

                          customToast(context, color: Colors.blue,
                            text: 'registration is success',);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            // toast.showToast(child: CustomToast(text: 'The password provided is too weak.',));
                          } else if (e.code == 'email-already-in-use') {
                            // toast.showToast(child: CustomToast(text: 'The account already exists for that email.',));
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}
