import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:wits_bus/models/Driver.dart';
import 'package:wits_bus/screens/Available_Drivers.dart';
import 'package:wits_bus/services/Database.dart';

import 'Drivers_tile.dart';

class Student_Home extends StatefulWidget {
  const Student_Home({super.key});

  @override
  State<Student_Home> createState() => _Student_HomeState();
}

class _Student_HomeState extends State<Student_Home> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(-26.17825, 28.035), zoom: 17);

  late GoogleMapController _googleMapController;


    double? latitude;
    double? longitude;

    Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

    void onMapCreated(GoogleMapController controller) async {

      _googleMapController = controller;


    }

     initMarker(specify, specifyId) async {
      var markerIdVal = specifyId;
      final MarkerId markerId = MarkerId(markerIdVal);
      final Marker marker = Marker(
        markerId: markerId,
        position:
        LatLng(specify['latitude'], specify['longitude']),
        infoWindow: InfoWindow(title: specify['name']),
      );
      setState(() {
        markers[markerId] = marker;
        //print(markerId);
      });
    }


    CollectionReference driver = FirebaseFirestore.instance.collection('location');

    getMarkerData() {
      driver.snapshots().listen((querySnapshot) {
        markers.clear();
        querySnapshot.docs.forEach((doc) {
          initMarker(doc.data(), doc.id);
        });
      });

    }


  @override
  void initState() {
    // TODO: implement initState
    getMarkerData();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController.dispose();
    super.dispose();
  }


  void _showDrivers() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.30,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Availabe_Drivers(),
        );
      }, isScrollControlled: true);
    }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(

          backgroundColor: Colors.blue,
          elevation: 0,
          title: Text('Bus Tracker'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            TextButton.icon(
                onPressed: () {
                  _showDrivers();
                },
                icon: Icon(Icons.location_searching , color: Colors.white,),
                label: Text('Track bus'))
          ],
        ),


        body: Stack(children: [
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SizedBox(
                  child: GoogleMap(
                    zoomControlsEnabled: true,
                    initialCameraPosition: _initialCameraPosition,
                    onMapCreated : onMapCreated,
                    markers: Set<Marker>.of(markers.values)


                  ),
                );
              })

        ]),
      );
  }
}
