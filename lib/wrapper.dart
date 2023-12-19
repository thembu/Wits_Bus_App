import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wits_bus/authenticate.dart';
import 'package:wits_bus/models/Driver.dart';
import 'package:wits_bus/models/Users.dart';
import 'package:wits_bus/screens/Driver_Home.dart';
import 'package:wits_bus/screens/Home.dart';
import 'package:wits_bus/screens/Login.dart';
import 'package:wits_bus/screens/Menu.dart';
import 'package:wits_bus/screens/Student_Home.dart';

class Wrapper extends StatefulWidget {
  static bool student = true;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users?>(context);



    if(user == null) {
      return Authenticate();

    } else if(user != null && Wrapper.student == true){
      return Menu();
    }
    else {
      return Driver_Home();
    }
  }
}
