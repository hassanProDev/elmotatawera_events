import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendedGuestsScreen extends StatelessWidget {
  const AttendedGuestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit=BlocProvider.of(context);
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(child: ListView.builder(itemBuilder: (_, index) {
                return Container();
              }))
            ],
          );
        },
      ),
    );
  }
}
