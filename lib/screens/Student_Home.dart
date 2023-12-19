import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wits_bus/screens/Available_Drivers.dart';

import '../services/auth.dart';


class Student_Home extends StatefulWidget {
  const Student_Home({super.key});




  @override
  State<Student_Home> createState() => _Student_HomeState();
}

class _Student_HomeState extends State<Student_Home> {

  final AuthService _auth = AuthService();

   static const _initialCameraPosition = CameraPosition(target:  LatLng(-26.1929 , 28.0305), zoom: 17);
    double? latitude;
    double? longitude;

    Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS


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


    void onMapCreated(GoogleMapController controller) {
      Available_Drivers.googleMapController = controller;
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
    super.dispose();
  }


  void _showDrivers() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20) )
          ),
          builder: (context) {

        return Container(
          height: MediaQuery.of(context).size.height * 0.30,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          margin:EdgeInsets.only(left: 20 , right: 10, bottom: 10 ) ,

          child: Available_Drivers(),
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
              Navigator.pushReplacementNamed(context, '/menu')
             ;
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
                    onMapCreated : onMapCreated ,
                    markers: Set<Marker>.of(markers.values)

                  ),
                );
              })

        ]),
      );
  }
}
