
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Available_Drivers extends  StatefulWidget{


  const Available_Drivers({super.key});

  static   var driver_latitude ;
  static   var driver_longitude ;
  static  GoogleMapController? googleMapController;


  @override
  State<Available_Drivers> createState() => _Available_DriversState();
}
class _Available_DriversState extends State<Available_Drivers> {


  var collection = FirebaseFirestore.instance.collection('location');
  late List<Map<String, dynamic>> drivers ;
  bool isLoaded = false;
  List<double> distances = [];


  Location location = new Location();
  StreamSubscription<LocationData>? location_sub;
  LocationData? _currentPosition;
  double?  user_latitude;
  double? user_longitude;

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

    location_sub = location.onLocationChanged.listen((LocationData currentLocation)
    {

      if(mounted) {
        setState(() {
          _currentPosition = currentLocation;
          user_latitude = _currentPosition?.latitude;
          user_longitude = _currentPosition?.longitude;
        });
      }
    });


  }

  _increment() async {
    List<Map<String, dynamic>> tempList = [];

    var data = await collection.where('route', isNull: false).get();
    for (var driver in data.docs) {
      tempList.add(driver.data()); // adds all fields to list
    }

    if (mounted) {

      setState(() {
        drivers = tempList;

        if (user_longitude != null && user_latitude != null) {
          distances.clear(); // Clear the distances list before recalculating
          for (int i = 0; i < drivers.length; i++) {
            double distance = Geolocator.distanceBetween(
                user_latitude!, user_longitude!, drivers[i]['latitude'],
                drivers[i]['longitude']);

            distances.add(distance);
            print('distance gotten');

          }

          if (distances.isNotEmpty) {
            Available_Drivers.driver_latitude = drivers[0]['latitude'];
            Available_Drivers.driver_longitude = drivers[0]['longitude'];
            isLoaded = true;
          }
        }
      });
    }
  }
  @override
  void initState() {
    super.initState();
    fetchLocation();
    _increment();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    location_sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: isLoaded
          ? ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            child: ListTile(
              onTap: () {
                setState(() {
                  Available_Drivers.googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(target: LatLng( drivers[index]["latitude"],drivers[index]["longitude"] ), zoom: 17)));
                });
              },
              leading: const CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/man.png')),
              title: Text('${drivers[index]["route"]} '),
              trailing: Text('${(distances[index].round().toInt())/100}'),
            ),
          );
        },
      )
          : const Text("Calculating ..."),
    );
  }
}
