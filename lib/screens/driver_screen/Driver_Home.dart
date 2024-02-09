import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' ;
import 'package:provider/provider.dart';
import 'package:wits_bus/services/Database.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:wits_bus/services/auth.dart';


import '../../models/Driver.dart';
import '../../models/Users.dart';


enum Genders{male , female}


class Driver_Home extends StatefulWidget {
  const Driver_Home({super.key});

  @override
  State<Driver_Home> createState() => _Driver_HomeState();
}

class _Driver_HomeState extends State<Driver_Home> {

  final AuthService _auth = AuthService();

    Location location = new Location();
    LocationData? _currentPosition;



  fetchLocation() async {

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {

      setState(() {
        _currentPosition = currentLocation;
      });

    });



  }

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }


  String bus = 'Choose a bus';

  var buses = [ // list of buses at wits and routes
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

    super.dispose();
  }


  Genders? gender = Genders.male;
  String?  selectedValue;





  @override
  Widget build(BuildContext context) {

    print(_currentPosition?.latitude);
    print(_currentPosition?.longitude);


    final driver = Provider.of<Users>(context);

    final _driver = DatabaseService(uid: driver.uid!);

    return StreamBuilder<Driver?>(
      stream: DatabaseService(uid: _driver.uid).userData,
      builder: (context, snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Driver Home page'),
            centerTitle: true,
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
              _auth.signOut();
            },),
          ),

          body: Form(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  CircleAvatar(
                    backgroundImage: AssetImage('assets/driver.jpg'),
                    radius: 80,
                  ),

                  SizedBox(height: 20,),


                  SizedBox(height: 20,),

                  ListTile(

                    title: const Text('Male'),
                    leading: Radio<Genders>(
                      value: Genders.male,
                      groupValue: gender,
                      onChanged: (Genders? value) {
                        setState(() {
                          gender = value;
                          selectedValue = value as String?;
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
                      return DropdownMenuItem(value: bus, child: Text(bus),);
                    }).toList(), onChanged: (String? value) {
                    setState(() {
                      bus = value!;
                      selectedValue = value;
                    });
                  },

                  ),

                  SizedBox(height: 20,),

                  ElevatedButton(
                    onPressed: () async{
                      await _driver.uploadDriver(selectedValue!);
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
            ),
          ),
        );
      }
    );
  }
}

