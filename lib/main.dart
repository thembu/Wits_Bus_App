
import 'package:wits_bus/models/Users.dart';
import 'package:wits_bus/screens/driver_screen/Driver_Home.dart';
import 'package:wits_bus/screens/menu/Home.dart';
import 'package:wits_bus/screens/registration_log_in/Login.dart';
import 'package:wits_bus/screens/menu/Menu.dart';
import 'package:wits_bus/screens/student_screen/drawer.dart';
import 'package:wits_bus/screens/student_screen/Student_Home.dart';
import 'package:wits_bus/screens/student_screen/bus_schedule.dart';
import 'package:wits_bus/screens/student_screen/profile.dart';
import 'package:wits_bus/screens/registration_log_in/splash.dart';
import 'package:wits_bus/screens/student_screen/timer.dart';
import 'package:wits_bus/wrapper.dart';
import 'package:wits_bus/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value( //we are now listening to the user stream
      value: AuthService().user,
      catchError: (_, err) =>  null,
      initialData: null,
      child:  MaterialApp(
        home: Splash_Screen(),

        routes: {
          '/map' : (context) => Student_Home(),
          '/menu' : (context) => Menu(),
          '/driver' :(context) => Driver_Home(),
          '/schedule' : (context) => Bus_Schedule(),
          '/profile' : (context) => Profile(),
          '/timer' : (context) => Timer()
        },
      ),
    );
  }
}
