import 'dart:io';

import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

class AttendedGuestsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return C0ntainer(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: SizeManager.size12),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeManager.size22),
                    child: GlobalRichText(
                      firstString: myCubit.selectedEventModel!.eventData.title,
                      secondString: " Attendance",
                    ),
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
                  },),
                  Expanded(
                    child: ListView.builder(
                        itemCount: myCubit.allAttendance.length,
                        itemBuilder: (_, index) {
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(SizeManager.size12),
                            ),
                            child: ListTile(
                              title: Text(
                                myCubit.allAttendance[index].attendanceData
                                        .firstName +
                                    " " +
                                    myCubit.allAttendance[index].attendanceData
                                        .lastName,
                                style: GoogleFonts.poppins(
                                  fontSize: SizeManager.size12,
                                  color: ColorManager.deepBlue,
                                ),
                              ),
                              subtitle: Text(
                                '''${myCubit.allAttendance[index].dateTime!.year}/${myCubit.allAttendance[index].dateTime!.month}/${myCubit.allAttendance[index].dateTime!.day}
                        ''',
                                style: GoogleFonts.poppins(
                                  fontSize: SizeManager.size12,
                                  color: ColorManager.deepBlue,
                                ),
                              ),
                              trailing: Text(
                                '''${myCubit.allAttendance[index].dateTime!.hour}:${myCubit.allAttendance[index].dateTime!.minute}
                        ''',
                                style: GoogleFonts.poppins(
                                  fontSize: SizeManager.size12,
                                  color: ColorManager.deepBlue,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
