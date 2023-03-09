// import 'dart:convert';
// import 'dart:io';
//
// import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
// import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
// import 'package:elmotatawera_events/data/model/guest_model.dart';
// import 'package:elmotatawera_events/utils/helper.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
//
// class QrScnnerScreen extends StatelessWidget {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   @override
//   Widget build(BuildContext context) {
//     AppCubit myCubit=BlocProvider.of(context);
//     return BlocListener<AppCubit, AppState>(
//       listener: (context, state) {
//         // TODO: implement listener
//         if(state is ScanQrSuccess){
//           Navigator.pushNamed(
//               context, RouteNameManager.attendanceScreen);
//         }else if(state is ScanQrFailer){
//           customToast(context,text: state.errorMessage);
//         }
//
//       },
//       child: Scaffold(
//         body: Column(
//           children: <Widget>[
//             // Expanded(
//             //   flex: 6,
//             //   child: QRView(
//             //     key: qrKey,
//             //     onQRViewCreated: (QRViewController controller) {
//             //       controller.scannedDataStream.listen((scanData) {
//             //         result=scanData;
//             //         myCubit.scanQr(scanData);
//             //       });
//             //     },
//             //   ),
//             // ),
//             Expanded(
//                 child: Container(
//                   color: Colors.white,
//                   child: Text(null ?? ""),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
//
// }
