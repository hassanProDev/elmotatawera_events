import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/presentation/screens/admin/baned_user/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestsAccountsScreens extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: BlocProvider.of<AppCubit>(context).getAllActiveUsersList.where((e)=>e.userData.userType=="Guest").toList().length,
        itemBuilder: (context, index) {
          return UserTile(userModel: BlocProvider.of<AppCubit>(context).getAllActiveUsersList.where((e)=>e.userData.userType=="Guest").toList()[index]);
        },
      ),
    );
  }
}
