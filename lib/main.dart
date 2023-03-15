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
          // BlocProvider(create: create),
          BlocProvider<AppCubit>(
            create: (context) {
              return AppCubit()
                ..getData()
                ..getAllActiveEvents()
                ..getAllUnActiveEvents()
                ..getAllEvents()
                ..updateChatState(true);
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
