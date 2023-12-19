
import 'package:wits_bus/models/Users.dart';
import 'package:wits_bus/screens/Home.dart';
import 'package:wits_bus/screens/Login.dart';
import 'package:wits_bus/screens/Menu.dart';
import 'package:wits_bus/screens/Student_Home.dart';
import 'package:wits_bus/screens/bus_schedule.dart';
import 'package:wits_bus/screens/splash.dart';
import 'package:wits_bus/wrapper.dart';
import 'package:wits_bus/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'models/Driver.dart';
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
          '/schedule' : (context) => Bus_Schedule()
        },
      ),
    );
  }
}
