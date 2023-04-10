import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/presentation/screens/registration/widget/custom_textformfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {},
      child: C0ntainer(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Form(
                key: myCubit.changePasswordFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.sp),
                      child: const GlobalRichText(
                        firstString: "Change",
                        secondString: " Password",
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFormField(
                      text: "old password",
                      controller: myCubit.oldPassword,
                      iconData: myCubit.loginPasswordIcon,
                      isPassword: myCubit.loginPasswordVisibilty,
                      onClick: () {
                        myCubit.changeLoginPasswordVisibilty();
                      },
                    ),
                    CustomTextFormField(
                      text: "new password",
                      iconData: myCubit.loginPasswordIcon,
                      isPassword: myCubit.loginPasswordVisibilty,
                      controller: myCubit.newPassword,
                      onClick: () {
                        myCubit.changeLoginPasswordVisibilty();
                      },
                    ),
                    CustomTextFormField(
                      text: "confirm password",
                      iconData: myCubit.loginPasswordIcon,
                      isPassword: myCubit.loginPasswordVisibilty,
                      controller: myCubit.confirmNewPassword,
                      validator: (value) {
                        if (myCubit.newPassword.text !=
                            myCubit.confirmNewPassword.text) {
                          return "the confirmed password not equal new password";
                        }
                      },
                      onClick: () {
                        myCubit.changeLoginPasswordVisibilty();
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomButton(
                      text: "Change password",
                      color: ColorManager.deepBlue,
                      onTap: () async {
                        if (myCubit.changePasswordFormKey.currentState!
                            .validate()) {
                          await myCubit.changePassword(
                            myCubit.getUserData!.userData.email,
                            myCubit.oldPassword.text,
                            myCubit.newPassword.text,
                          );
                          myCubit.resetChangePasswordField();
                          Navigator.pop(context);
                        }
                      },
                    ),
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
