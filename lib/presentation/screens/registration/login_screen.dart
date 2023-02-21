import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/presentation/screens/registration/widget/custom_textformfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit myCubit=BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: GlobalRichText(
              firstString: "ElMotatawera", secondString: "Events",),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  GlobalRichText(
                    firstString: "ElMotatawera", secondString: "Events",),
                  SizedBox(height: 24.h,),
                  CustomTextFormField(
                    text: "email",
                  ),
                  CustomTextFormField(
                    text: "password",
                    iconData:myCubit.loginPasswordIcon ,
                    isPassword: myCubit.loginPasswordVisibilty,
                    onClick:() {
                      myCubit.changeLoginPasswordVisibilty();
                    },
                  ),
                  CustomButton(text: "Login", color: Colors.red,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
