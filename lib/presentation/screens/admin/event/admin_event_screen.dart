import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/pressed_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminEventScreen extends StatelessWidget {
  const AdminEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myCubit = BlocProvider.of<AppCubit>(context);

    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        body: Column(
          children: [
            Image.asset("assets/images/activity_img.jpg"),
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(SizeManager.size16),
                  topLeft: Radius.circular(SizeManager.size16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextBlue(
                    myCubit.selectedEventModel!.title,
                    fontSize: SizeManager.size13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBlue(
                        myCubit.selectedEventModel!.isPaid ? "Paid" : "un paid",
                        fontWeight: FontWeight.bold,
                        fontSize: SizeManager.size12,
                      ),
                      TextBlue(
                        "price : ${myCubit.selectedEventModel!.price}",
                        fontWeight: FontWeight.bold,
                        fontSize: SizeManager.size12,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBlue(
                        "2023 - 12 - 5",
                        fontWeight: FontWeight.bold,
                        fontSize: SizeManager.size12,
                      ),
                      TextBlue(
                        "05:30",
                        fontWeight: FontWeight.bold,
                        fontSize: SizeManager.size12,
                      )
                    ],
                  ),
                  TextBlue(
                    "Location : ${myCubit.selectedEventModel!.location}",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  ),
                  GlobalPressedText(
                    text: "Get Maps",
                    onTap: () {},
                  ),
                  TextBlue(
                    myCubit.selectedEventModel!.description ?? "",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  ),
                  TextBlue(
                    "max people count",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
