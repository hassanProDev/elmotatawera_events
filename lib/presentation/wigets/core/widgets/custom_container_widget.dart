import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;

  const CustomContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Visibility(
          child: child!,
          visible: true// BlocProvider.of<AppCubit>(context).dontTrickMe,
        );
      },
    );
  }
}
