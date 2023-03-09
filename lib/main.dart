import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/presentation/theming/app_theming.dart';
import 'package:elmotatawera_events/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) {
              return AppCubit()
                // ..gcon()
                ..getAllEvents()
                ..getAllUnActiveEvents()
                ..getAllActiveEvents();
            },
          ),
        ],
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RouteNameManager.splashScreen,
              onGenerateRoute: RoutesManager.generateRoute,
              theme: AppTheming().lightTheme,
            );
          },
        ),
      );
    });
  }
}

// import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
// import 'package:elmotatawera_events/firebase_options.dart';
// import 'package:elmotatawera_events/route_manager.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';
// import 'package:sizer/sizer.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, deviceType) {
//       return MaterialApp(
//        home: MyHomePage(),
//       );
//     });
//   }
// }
//
//
//
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String? text;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//             child: PrettyQr(
//               size: 300,
//               data: text??"any",
//             ),
//           ),
//           TextField(
//             onChanged: (value){
//               text=value;
//               setState(() {
//
//               });
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
