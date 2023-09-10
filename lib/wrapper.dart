import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wits_bus/authenticate.dart';
import 'package:wits_bus/models/Driver.dart';
import 'package:wits_bus/screens/Home.dart';
import 'package:wits_bus/screens/Login.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Driver?>(context);

    if(user == null) {
      return Authenticate();
    } else {
      print(user);
      return Home();
    }
  }
}
