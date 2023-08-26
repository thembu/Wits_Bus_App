


import 'package:flutter/material.dart';
import 'package:wits_bus/Components/Driver_Home.dart';
import 'package:wits_bus/Components/Driver_Load.dart';
import 'package:wits_bus/Components/Log_in.dart';
import 'package:wits_bus/Components/Student_Home.dart';
import 'package:wits_bus/Components/Loading.dart';

void main() async {
  runApp(MaterialApp(
    initialRoute: '/Login',
    routes: {
      '/Login': (context) => Log_in(),
      'Student_Home' : (context) => Student_Home(),
         'Loading' : (context) => Loading(),
      'Driver_Load' :(context) => Driver_Load(),
      'Driver_Home' : (context) => Driver_Home(),

    },
  ));
}

