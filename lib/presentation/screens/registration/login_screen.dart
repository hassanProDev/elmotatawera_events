import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/consts.dart';
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

class LoginScreen extends StatelessWidget {
  bool isLoading = false;

  String? email;

  String? password;

  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          customToast(
            context,
            text: "Login is Success",
          );
        } else if (state is LoginFailer) {
          isLoading = false;
          customToast(
            context,
            text: state.errorMessage,
          );
        }
        if (state is GetUserSuccess) {
          isLoading = false;
        } else if (state is GetUserFailer) {
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
                key: myCubit.loginFormKey,
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
                      height: 20.h,
                    ),
                    CustomTextFormField(
                      text: "email",
                      controller: myCubit.loginEmail,
                    ),
                    CustomTextFormField(
                      text: "password",
                      iconData: myCubit.loginPasswordIcon,
                      isPassword: myCubit.loginPasswordVisibilty,
                      controller: myCubit.loginPassword,
                      onClick: () {
                        myCubit.changeLoginPasswordVisibilty();
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomButton(
                      text: "Login",
                      color: ColorManager.deepBlue,
                      onTap: () async {
                        if (myCubit.loginFormKey.currentState!.validate()) {
                          await myCubit.userLogin(myCubit.loginEmail.text, myCubit.loginPassword.text).then((v){
                           myCubit.init();
                            Navigator.pushReplacementNamed(
                                context, myCubit.getUserData!.userData.userType);
                            myCubit.clearLoginController();
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    myCubit.appSetting[kCanSignUp]?GlobalPressedText(
                      text: "Sign Up",
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RouteNameManager.signUpScreen);
                      },
                    ):Container(),
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
