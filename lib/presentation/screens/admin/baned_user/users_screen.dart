import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/consts.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/screens/admin/baned_user/widgets/admins_accounts_scrrens.dart';
import 'package:elmotatawera_events/presentation/screens/admin/baned_user/widgets/banded_accounts_scrrens.dart';
import 'package:elmotatawera_events/presentation/screens/admin/baned_user/widgets/guests_accounts_screens.dart';
import 'package:elmotatawera_events/presentation/screens/admin/baned_user/widgets/securities_accounts_screen.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_deep_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class UsersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
        body:
        DefaultTabController(
          length: 4,
          animationDuration: Duration(milliseconds:500 ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeManager.size16),
                child: GlobalRichText(
                  firstString: "Users",
                  secondString: " Status",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextDeepBlue("Users Can Sign Up"),
                  Switch(value: BlocProvider.of<AppCubit>(context).appSetting[kCanSignUp], onChanged: (e){
                    BlocProvider.of<AppCubit>(context).updateSignUpState(e);
                  })
                ],),
              SizedBox(
                height: 6.sp,
              ),
              TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                onTap: (e){
                  BlocProvider.of<AppCubit>(context).changeUsersTabIndex(e);
                  print(BlocProvider.of<AppCubit>(context).usersTabIndex);
                },
                tabs: [
                  CustomTabItem(
                    isSelected: 0 == BlocProvider.of<AppCubit>(context).usersTabIndex,
                    text: "Guests",

                  ),
                  CustomTabItem(
                    isSelected: 1 == BlocProvider.of<AppCubit>(context).usersTabIndex,
                    text: "Securities",

                  ),
                  CustomTabItem(
                    isSelected: 2 == BlocProvider.of<AppCubit>(context).usersTabIndex,
                    text: "Admins",

                  ),
                  CustomTabItem(
                    isSelected: 3 == BlocProvider.of<AppCubit>(context).usersTabIndex,
                    text: "Blocked Users",

                  ),
                ],
              ),
              SizedBox(
                height: 12.sp,
              ),

              [
                GuestsAccountsScreens(),
                SecuritiesAccountsScreens(),
                AdminsAccountsScreens(),
                BandedAccountsScreens(),
              ][BlocProvider.of<AppCubit>(context).usersTabIndex]
            ],
          ),
        ),
      );
  },
);

  }
}
