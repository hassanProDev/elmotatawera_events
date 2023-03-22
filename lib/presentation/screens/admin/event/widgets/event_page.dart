import 'dart:io';

import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/pressed_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatelessWidget {
  // EventPage({Key? key,required this.myCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    return C0ntainer(
      child: SlidingUpPanel(
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        color: Colors.transparent,
        body: myCubit.selectedEventModel!.eventData.img == null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GlobalRichText(
                      firstString: "Using",
                      secondString: "El Motatawera",
                    ),
                    SizedBox(
                      height: SizeManager.size28,
                    ),
                    CustomButton(text: "Generate Excel Sheet",onTap: ()async{
                      final excel.Workbook workbook= excel.Workbook();
                      final excel.Worksheet sheet=workbook.worksheets[0];
                      excel.Style globalStyle = workbook.styles.add('style');
                      globalStyle.backColor = '#012840';
                      globalStyle.fontName = 'Times New Roman';
                      globalStyle.fontSize = 14;
                      globalStyle.fontColor = '#ffffff';
                      globalStyle.bold = true;
                      sheet.getRangeByName('A1').cellStyle=globalStyle;
                      sheet.getRangeByName('B1').cellStyle=globalStyle;
                      sheet.getRangeByName('C1').cellStyle=globalStyle;
                      sheet.getRangeByName('D1').cellStyle=globalStyle;
                      sheet.getRangeByName('E1').cellStyle=globalStyle;
                      sheet.getRangeByName('A1').setText("Guest Name");
                      sheet.getRangeByName('B1').setText("Available Invite");
                      sheet.getRangeByName('C1').setText("Guest Count");
                      sheet.getRangeByName('D1').setText("Attendance Count");
                      sheet.getRangeByName('E1').setText("Guest Absence");
                      double totalGuestCount=0;
                      double totalAvailableInvite=0;
                      double totalAttendanceCount=0;
                      for(int i=0;i<myCubit.allConfirmedGuests.length;i++){
                        sheet.getRangeByName('A${i+2}').setText("${myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyFirstName]} ${myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyLastName]}");
                        sheet.getRangeByName('B${i+2}').setNumber(double.parse("${myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyAvailableInvite]}"));
                        sheet.getRangeByName('C${i+2}').setNumber(double.parse("${myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyPeopleCount]}"));
                        sheet.getRangeByName('D${i+2}').setNumber(double.parse("${myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyPeopleCount]-myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyAvailableInvite]}"));
                        sheet.getRangeByName('E${i+2}').setText(myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyPeopleCount]-myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyAvailableInvite]==0?"Absence":"Attendance");
                        totalAvailableInvite+=myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyAvailableInvite];
                        totalGuestCount+=myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyPeopleCount];
                        totalAttendanceCount+=myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyPeopleCount]-myCubit.allConfirmedGuests[i].guestData.toJson()[GuestData.keyAvailableInvite];
                        if(i+1==myCubit.allConfirmedGuests.length){
                          sheet.getRangeByName('A${i+3}').cellStyle=globalStyle;
                          sheet.getRangeByName('A${i+3}').setText("Total");
                          sheet.getRangeByName('B${i+3}').setNumber(totalAvailableInvite);
                          sheet.getRangeByName('C${i+3}').setNumber(totalGuestCount);
                          sheet.getRangeByName('D${i+3}').setNumber(totalAttendanceCount);
                        }
                      }
                      final List<int> bytes=workbook.saveAsStream();
                      workbook.dispose();
                      final String path=(await getApplicationSupportDirectory()).path;
                      final String fileName='$path/${myCubit.selectedEventModel!.eventData.title} Attendance ${DateTime.now()}.xlsx';
                      final File file=File(fileName);
                      await file.writeAsBytes(bytes,flush: true);
                      OpenFilex.open(fileName);
                    },)
                    // CustomButton(
                    //   text: "Attendance",
                    //   onTap: () {
                    //     myCubit.getAllAttendance(myCubit.selectedEventModel!.eventData.docId!);
                    //     Navigator.pushNamed(context, RouteNameManager.guestAttendanceScreen);
                    //   },
                    // )
                  ],
                ),
              )
            : Image.file(
                File(myCubit.selectedEventModel!.eventData.img!),
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
                myCubit.selectedEventModel!.eventData.title,
                fontSize: SizeManager.size18,
                fontWeight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBlue(
                    myCubit.selectedEventModel!.eventData.isPaid
                        ? "Paid"
                        : "un paid",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  ),
                  TextBlue(
                    "price : ${myCubit.selectedEventModel!.eventData.price}",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBlue(
                    "${myCubit.selectedEventModel!.eventData.dateTime.year} - ${myCubit.selectedEventModel!.eventData.dateTime.month}  - ${myCubit.selectedEventModel!.eventData.dateTime.day} ",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  ),
                  TextBlue(
                    "${myCubit.selectedEventModel!.eventData.dateTime.hour}:${myCubit.selectedEventModel!.eventData.dateTime.minute} ",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  )
                ],
              ),
              TextBlue(
                "Location : ${myCubit.selectedEventModel!.eventData.location}",
                fontWeight: FontWeight.bold,
                fontSize: SizeManager.size11,
              ),
              GlobalPressedText(
                text: "Get Maps",
                onTap: () async {
                  if (!await launchUrl(
                      Uri.parse(myCubit.selectedEventModel!.eventData.locationUrl,))) {
                    throw Exception(
                        'Could not launch ${myCubit.selectedEventModel!.eventData.locationUrl}');
                  }
                },
              ),
              TextBlue(
                "Description",
                fontWeight: FontWeight.bold,
                fontSize: SizeManager.size12,
              ),
              TextBlue(
                myCubit.selectedEventModel!.eventData.description ?? "",
                fontWeight: FontWeight.bold,
                fontSize: SizeManager.size10,
              ),
              TextBlue(
                "People Count: " +
                    myCubit.selectedEventModel!.eventData.peopleCount.toString(),
                fontWeight: FontWeight.bold,
                fontSize: SizeManager.size12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
