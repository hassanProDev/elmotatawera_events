import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/regex_manager.dart';
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
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatelessWidget {
  bool isLoading = false;
  String? userType;

  SignUpScreen({this.userType, super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    print(myCubit.appSetting)
    ;
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSuccess) {
          isLoading = false;
          if (userType == null) {
            Navigator.pushReplacementNamed(
                context, RouteNameManager.loginScreen);
          } else {
            Navigator.pop(context);
          }
          customToast(
            context,
            text: "Registration is Success",
          );
        } else if (state is SignUpFailer) {
          isLoading = false;
          customToast(
            context,
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
                        firstString: userType != null ? "New" : "El Motatawera",
                        secondString: userType ?? " Events",
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextFormField(
                      text: "first name",
                      controller: myCubit.signUpFirstName,
                      regexCondition: RegexManager.stringRegex,
                    ),
                    CustomTextFormField(
                      text: "last name",
                      controller: myCubit.signUpLastName,
                      regexCondition: RegexManager.stringRegex,
                    ),
                    CustomTextFormField(
                      text: "phone",
                      controller: myCubit.signUpPhone,
                      regexCondition: RegexManager.phoneRegex,
                    ),
                    CustomTextFormField(
                      text: "email",
                      controller: myCubit.signUpEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomTextFormField(
                      text: "password",
                      isPassword: myCubit.signUpPasswordVisibilty,
                      controller: myCubit.signUpPassword,
                      iconData: myCubit.signUpPasswordIcon,
                      onClick: () {
                        myCubit.changeSignUpPasswordVisibilty();
                      },
                    ),
                    CustomTextFormField(
                      text: "confirm-password",
                      iconData: myCubit.signUpPasswordIcon,
                      isPassword: myCubit.signUpPasswordVisibilty,
                      controller: myCubit.signUpConfirmPassword,
                      validator: (value) {
                        if (myCubit.signUpPassword.text !=
                            myCubit.signUpConfirmPassword.text) {
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
                          await myCubit.userSignUp(myCubit.signUpEmail.text,
                              myCubit.signUpPassword.text);
                          await myCubit
                              .addUser(UserModel(
                            userData: UserData(
                                firstName: myCubit.signUpFirstName.text,
                                lastName: myCubit.signUpLastName.text,
                                phone: myCubit.signUpPhone.text,
                                userType: userType ??
                                    RouteNameManager.homeGuestScreen,
                                email: myCubit.userCredential!.user!.email!),
                            uid: myCubit.userCredential!.user!.uid,
                          ))
                              .then((value) {


                            myCubit.clearSignUpController();
                          });
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
