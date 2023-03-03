import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/pressed_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminEventScreen extends StatelessWidget {
  var panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    var myCubit = BlocProvider.of<AppCubit>(context);

    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        body: SlidingUpPanel(
          controller: panelController,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          color: Colors.transparent,
          body: Image.asset(
            "assets/images/activity_img.jpg",
            fit: BoxFit.fill,
          ),
          panelBuilder: (scroller) => Container(
            padding: EdgeInsets.all(SizeManager.size12),
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(SizeManager.size22),
                topLeft: Radius.circular(SizeManager.size22),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextBlue(
                  myCubit.selectedEventModel!.title,
                  fontSize: SizeManager.size16,
                  fontWeight: FontWeight.bold,
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
                      "${myCubit.selectedEventModel!.dateTime.year} - ${myCubit.selectedEventModel!.dateTime.month}  - ${myCubit.selectedEventModel!.dateTime.day} ",
                      fontWeight: FontWeight.bold,
                      fontSize: SizeManager.size12,
                    ),
                    TextBlue(
                      "${myCubit.selectedEventModel!.dateTime.hour}:${myCubit.selectedEventModel!.dateTime.minute} ",
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
                  onTap: () async{
                    if (!await launchUrl(Uri.parse(myCubit.selectedEventModel!.locationUrl))) {
                    throw Exception('Could not launch ${myCubit.selectedEventModel!.locationUrl}');
                    }
                  },
                ),
                TextBlue(
                  myCubit.selectedEventModel!.description ?? "",
                  fontWeight: FontWeight.bold,
                  fontSize: SizeManager.size12,
                ),
                TextBlue(
                  myCubit.selectedEventModel!.peopleCount.toString(),
                  fontWeight: FontWeight.bold,
                  fontSize: SizeManager.size12,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorManager.blueColor,
          child: Icon(Icons.chat),
          onPressed: (){
            // myCubit.getSelectedEventModel(myCubit.selectedEventModel!);
            myCubit.getAllMessage(myCubit.selectedEventModel!.docId);
            print(" ********* all messages **************");
            print(myCubit.allMessages);
            Navigator.pushNamed(context, RouteNameManager.chatScreen);
          },
        ),
        bottomNavigationBar:  CurvedNavigationBar(
          color: ColorManager.blueColor,
          backgroundColor: ColorManager.redColor,
          items: <Widget>[
            Icon(Icons.add, size: 30,color: ColorManager.offWhite,),
            Icon(Icons.list, size: 30,color: ColorManager.offWhite,),
            Icon(Icons.compare_arrows, size: 30,color: ColorManager.offWhite,),
          ],
          onTap: (index) {
            //Handle button tap
          },
        ),
      ),
    );
  }
}
