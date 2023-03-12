import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/screens/admin/guest_admin_screen/widgets/guest_tile.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmedGuestScreen extends StatelessWidget {
  const ConfirmedGuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return C0ntainer(
          child: DefaultTabController(
            length: 2,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: SizeManager.size10),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: SizeManager.size16),
                    child: GlobalRichText(
                      firstString: "Confirmed",
                      secondString: " Guests",
                    ),
                  ),
                  TabBar(
                    indicatorColor: Colors.transparent,
                      onTap: (index) {
                        myCubit.changeGuestTabIndex(index);
                      },
                      tabs: [
                        CustomTabItem(
                          text: "My Guests",
                          isSelected: 0 == myCubit.guestTabIndex,
                        ), CustomTabItem(
                          text: "Confirmed Guests",
                          isSelected: 1 == myCubit.guestTabIndex,
                        ),
                      ]),
                  SizedBox(height: SizeManager.size16,),
                  [
                    Expanded(
                      child: ListView.builder(
                          itemCount: myCubit.getMyGuestsData.length,
                          itemBuilder: (context, index) {
                            return GuestTile(guestModel: myCubit.getMyGuestsData[index],);
                          }),
                    ), Expanded(
                    child: ListView.builder(
                        itemCount: myCubit.allConfirmedGuests.length,
                        itemBuilder: (context, index) {
                          return  GuestTile(guestModel: myCubit.allConfirmedGuests[index],);
                        }),
                  ),
                  ][myCubit.guestTabIndex]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
