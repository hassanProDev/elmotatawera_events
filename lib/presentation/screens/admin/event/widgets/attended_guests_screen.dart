import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
