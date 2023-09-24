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

  Future uploadUser(String name , String  route) async {

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

    location.onLocationChanged.listen((LocationData currentLocation) async {


      _currentPosition = currentLocation;

         await driver_data.doc(uid).set({
          'uid' : uid,
          'name' : name,
          'route' : route,
          'latitude' : _currentPosition?.latitude,
          'longitude' : _currentPosition?.longitude
        });

    });




  }



  Driver? _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Driver(uid: uid, name: snapshot.get('name') , route: snapshot.get('route'), latitude: snapshot.get('latitude'), longitude: snapshot.get('longitude'));
  }

  Stream<Driver?> get userData {

    return driver_data.doc(uid).snapshots().
    map(_userDataFromSnapshot);

  }

}




