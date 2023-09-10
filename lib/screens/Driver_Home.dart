import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


enum Genders{male , female}


class Driver_Home extends StatefulWidget {
  const Driver_Home({super.key});

  @override
  State<Driver_Home> createState() => _Driver_HomeState();
}

class _Driver_HomeState extends State<Driver_Home> {

  late TextEditingController _textEditingController;



  String bus = 'Choose a bus';

  var buses = [    // list of buses at wits and routes
    'Choose a bus',
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

  Genders? gender =  Genders.male;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Driver Home page'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back ) ,onPressed: () {Navigator.pop(context);},),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20 , 60 , 20 , 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            CircleAvatar(
              backgroundImage: AssetImage('assets/driver.jpg'),
              radius: 80,
            ),

          SizedBox(height: 20,),

          TextFormField(
         decoration: new InputDecoration(
          labelText: "Enter name and surname",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
          //fillColor: Colors.green
        ),

        keyboardType: TextInputType.emailAddress,
        style: new TextStyle(
          fontFamily: "Poppins",
         ),
        ),

            SizedBox(height: 20,),

            ListTile(

              title: const Text('Male'),
              leading: Radio<Genders>(
                value: Genders.male,
                groupValue: gender,
                onChanged: (Genders? value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),

            ),

            ListTile(

              title: const Text('Female'),
              leading: Radio<Genders>(
                value: Genders.female,
                groupValue: gender,
                onChanged: (Genders? value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),

            ),


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

      ElevatedButton(
        onPressed: () {

        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            minimumSize: Size(200, 50)
        ),


        child: Text('Depart', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18
        ),),
      ),




          ],
        ),
      ) ,
    );
  }
}
