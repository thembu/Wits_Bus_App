import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {

  TimeOfDay? time = const TimeOfDay(hour: 12,minute: 12);
  List<dynamic> times = [];



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Timer page'), leading: IconButton(icon :Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pushReplacementNamed(context, '/menu'),),),
      body: Center(
        child: Text(
          '${time!.hour.toString()} : ${time!.minute.toString()}',
              style: const TextStyle(fontSize: 60),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          TimeOfDay? newTime = await showTimePicker(context: context, initialTime: time!);
          if(newTime != null) {
            setState(() {
              time = newTime;
              times.add(time);
            });
          }
        },
        child: Icon(Icons.access_time),
      ),

    );
  }
}
