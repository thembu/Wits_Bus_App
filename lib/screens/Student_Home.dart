import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:wits_bus/screens/Available_Drivers.dart';

class Student_Home extends StatefulWidget {
  const Student_Home({super.key});

  @override
  State<Student_Home> createState() => _Student_HomeState();
}

class _Student_HomeState extends State<Student_Home> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(-26.17825, 28.035), zoom: 17);

  late GoogleMapController _googleMapController;


  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController.dispose();
    super.dispose();
  }

  late BitmapDescriptor markerIcon;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/res.png')
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    addCustomIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    void _showDrivers() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.30,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Availabe_Drivers(),
        );
      }, isScrollControlled: true);
    }


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
                onMapCreated: (controller) => _googleMapController = controller,
                markers: {
                  Marker(
                    markerId: MarkerId('knocks'),
                    position: LatLng(-26.17825, 28.035),
                    draggable: false,
                    icon: markerIcon,
                  ),
                  Marker(
                    markerId: MarkerId('eduaction campus'),
                    position: LatLng(-26.177235201257822, 28.044725365234946),
                    draggable: false,
                    icon: markerIcon,
                  ),
                  Marker(
                    markerId: MarkerId('Noswal hall'),
                    position: LatLng(-26.1919, 28.0336),
                    draggable: false,
                    icon: markerIcon,
                  ),
                  Marker(
                    markerId: MarkerId('Amani hall'),
                    position: LatLng(-26.192425105484414, 28.036520618226223),
                    draggable: false,
                    icon: markerIcon,
                  ),
                  Marker(
                      markerId: MarkerId('Wits Junction'),
                      position: LatLng(-26.181123510124333, 28.047331179786703),
                      draggable: false,
                      icon: markerIcon,
                      infoWindow: InfoWindow(title: 'Wits Junction')),
                }),
          );
            })
      ]),
    );
  }
}
