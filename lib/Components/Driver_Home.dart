import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Driver_Home extends StatefulWidget {
  const Driver_Home({super.key});

  @override
  State<Driver_Home> createState() => _Driver_HomeState();
}

class _Driver_HomeState extends State<Driver_Home> {

  late TextEditingController _textEditingController;



  String bus = 'Circuit Bus All-Res';

  var buses = [    // list of buses at wits and routes

    'Circuit Bus All-Res',
    'Circuit Bus Reverse',
    'WJ -> MAIN',
    'NSW -> AMH -> WEC',
    'WJ -> WEC -> MAIN',
    'MAIN -> NSW -> WEC',
    'NSW -> AMH -> WEC -> MAIN',
    'EOH -> KNK -> MAIN'
  ];





  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController = TextEditingController();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text('Driver Home page'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back ) ,onPressed: () {Navigator.pushReplacementNamed(context, '/Login');},),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20 , 60 , 20 , 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            TextField(
              decoration: InputDecoration(
                hintText: 'Name of driver',
                suffixIcon: IconButton(onPressed: () {_textEditingController.clear();}, icon: Icon(Icons.clear)),
                border: OutlineInputBorder(),

                )
              ),

            SizedBox(height: 20,),
            
            DropdownButton(

              value: bus,

              icon: Icon(Icons.keyboard_arrow_down),

              items: buses.map((String bus) {
                return DropdownMenuItem(value : bus , child: Text(bus),);
              }).toList(), onChanged: (String? value) { setState(() {
                bus = value!;
              }); },

            ),

             SizedBox(height: 20,),

             ButtonTheme(
                minWidth: 300,
                height: 100,
                child:
                ElevatedButton(onPressed: () {}, child: Text('Depart'), )
            ),


          ],
        ),
      ) ,
    );
  }
}
