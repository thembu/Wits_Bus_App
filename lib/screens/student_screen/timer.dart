import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wits_bus/services/Database.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {

  final CollectionReference users =  FirebaseFirestore.instance.collection('time');
  late List<Map<String, dynamic>> pick_up_time;

  TimeOfDay? time = const TimeOfDay(hour: 12,minute: 12);
  List<dynamic> times = [];




    @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Timer page'), leading: IconButton(icon :Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pushReplacementNamed(context, '/menu'),),),

      body: ListView.builder(
        itemCount: times.length,
        itemBuilder: (context , index) {
          return Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(onPressed: ((context) {

                }),
                backgroundColor: Colors.red,
                icon: Icons.delete,
                )
              ],
            ),
            child: Container(
              color: Colors.grey[300],
              child: ListTile(
                title: Text('${times[index]}'),
                leading: Icon(Icons.person, size : 40),
              ),
            ),
          );
        }
      ) ,


      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          TimeOfDay? newTime = await showTimePicker(context: context, initialTime: time!);
          if(newTime != null) {
            setState(() {
              time = newTime;
              times.add(time);
              print(time);
              DatabaseService(uid: 'null').uploadTime(times);
            });
          }
        },
        child: Icon(Icons.access_time),
      ),

    );
  }
}
