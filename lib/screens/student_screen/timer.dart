import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Timer page'), leading: IconButton(icon :Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pushReplacementNamed(context, '/menu'),),),
    );
  }
}
