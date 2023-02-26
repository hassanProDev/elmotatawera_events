import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/model/users_model.dart';
import 'package:elmotatawera_events/presentation/screens/registration/widget/custom_textformfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
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
            color: Colors.blue,
            text: "Login is Success",
          );
        } else if (state is LoginFailer) {
          isLoading = false;
          customToast(
            context,
            color: Colors.blue,
            text: state.errorMessage,
          );
        }
        if (state is GetUserSuccess) {
          isLoading = false;
        } else if (state is GetUserFailer) {
          customToast(
            context,
            color: Colors.blue,
            text: state.errorMessage,
          );
        }
      },
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
                    onChange: (value) {
                      email = value;
                    },
                  ),
                  CustomTextFormField(
                    text: "password",
                    iconData: myCubit.loginPasswordIcon,
                    isPassword: myCubit.loginPasswordVisibilty,
                    onChange: (value) {
                      password = value;
                    },
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
                        await myCubit.userLogin(email!, password!);
                        userModel = await myCubit
                            .getUser(myCubit.userCredential!.user!.uid);
                        Navigator.pushReplacementNamed(
                            context, userModel!.userType,
                            arguments: userModel);
                      }
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  GlobalPressedText(
                    text: "Sign Up",
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RouteNameManager.signUpScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
