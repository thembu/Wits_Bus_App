import 'package:flutter/material.dart';
import 'package:wits_bus/Components/Log_in.dart';
import 'package:wits_bus/Components/Student_Home.dart';
void main() async {
  runApp(MaterialApp(
    initialRoute: '/Login',
    routes: {
      '/Login': (context) => Log_in(),
      'Student_Home' : (context) => Student_Home()
    },
  ));
}

