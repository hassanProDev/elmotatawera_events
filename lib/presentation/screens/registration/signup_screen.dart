import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/model/users_model.dart';
import 'package:elmotatawera_events/presentation/screens/registration/widget/custom_textformfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/pressed_text.dart';
import 'package:elmotatawera_events/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatelessWidget {
  String? email;
  String? password;
  String? confirmPassword;
  String? firstName;
  String? lastName;
  String? phone;

  bool isLoading = false;
  String? userType;

  SignUpScreen({this.userType, super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSuccess) {
          isLoading = false;
          customToast(
            context,
            color: Colors.blue,
            text: "Registration is Success",
          );
          Navigator.pushReplacementNamed(
              context, userType ?? RouteNameManager.homeGuestScreen);
        } else if (state is SignUpFailer) {
          isLoading = false;
          customToast(
            context,
            color: Colors.blue,
            text: state.errorMessage,
          );
        }
      },
      child: C0ntainer(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Form(
                key: myCubit.signUpFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.sp),
                      child: GlobalRichText(
                        firstString: "El Motatawera",
                        secondString: " Events",
                      ),
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
                      iconData: myCubit.signUpPasswordIcon,
                      onClick: () {
                        myCubit.changeSignUpPasswordVisibilty();
                      },
                    ),
                    CustomTextFormField(
                      text: "confirm-password",
                      iconData: myCubit.signUpPasswordIcon,
                      isPassword: myCubit.signUpPasswordVisibilty,
                      onChange: (value) {
                        confirmPassword = value;
                      },
                      validator: (value) {
                        if (password != confirmPassword) {
                          return "please confirm your password";
                        }
                      },
                      onClick: () {
                        myCubit.changeSignUpPasswordVisibilty();
                      },
                    ),
                    CustomButton(
                      text: "Sign Up",
                      color: ColorManager.deepBlue,
                      onTap: () async {
                        if (myCubit.signUpFormKey.currentState!.validate()) {
                          await myCubit.userSignUp(email!, password!);
                          await myCubit.addUser(UserModel(
                            email: myCubit.userCredential!.user!.email,
                            uid: myCubit.userCredential!.user!.uid,
                            firstName: firstName!,
                            lastName: lastName!,
                            phone: phone!,
                            userType:
                                userType ?? RouteNameManager.homeGuestScreen,
                          ));
                        }
                      },
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    userType == null
                        ? GlobalPressedText(
                            text: "Login",
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, RouteNameManager.loginScreen);
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
