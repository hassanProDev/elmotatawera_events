import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/screens/admin/guest_admin_screen/widgets/guest_tile.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnConfirmedGuestScreen extends StatelessWidget {
  const UnConfirmedGuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeManager.size10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeManager.size16),
                child: GlobalRichText(
                  firstString: "UnConfirmed",
                  secondString: " Guests",
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: myCubit.allUnConfirmedGuests.length,
                      itemBuilder: (context, index) {
                        return GuestTile(
                            guestModel: myCubit.allUnConfirmedGuests[index]);
                      })),
            ],
          ),
        );
      },
    );
  }
}
