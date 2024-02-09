import 'dart:async';

import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wits_bus/models/Driver.dart';

Location location = new Location();
LocationData? _currentPosition;

class DatabaseService {

  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference driver_data =  FirebaseFirestore.instance.collection('location');

  Future uploadDriver(String  route) async {

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

    //initial upload



    location.onLocationChanged.listen((LocationData currentLocation) async {


      _currentPosition = currentLocation;

      await driver_data.doc(uid).set({
        'uid' : uid,
        'route' : route,
        'latitude' : _currentPosition?.latitude,
        'longitude' : _currentPosition?.longitude
      });

    });

    location.enableBackgroundMode(enable: true);



  }


  Driver? _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Driver(uid: uid,  route: snapshot.get('route'), latitude: snapshot.get('latitude'), longitude: snapshot.get('longitude'));
  }

  Stream<Driver?> get userData {

    return driver_data.doc(uid).snapshots().
    map(_userDataFromSnapshot);

  }

}




