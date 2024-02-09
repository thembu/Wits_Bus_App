import 'package:wits_bus/screens/registration_log_in/Register.dart';
import 'package:wits_bus/screens/registration_log_in/Login.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;


  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }


  @override
  Widget build(BuildContext context) {
    if(showSignIn) {
      return Log_in( toggleView: toggleView);
    }
    else {
      return Register(toggleView : toggleView);
    }
  }
}
