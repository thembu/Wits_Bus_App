import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:label_marker/label_marker.dart';

void getKey () async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
}


class Student_Home extends StatefulWidget {



  const Student_Home({super.key});

  @override
  State<Student_Home> createState() => _Student_HomeState();
}

class _Student_HomeState extends State<Student_Home> {



  static const _initialCameraPosition = CameraPosition(target: LatLng(-26.17825,28.035 ), zoom: 17);

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
        .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        }
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    getKey();
    addCustomIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: {

    Marker(
    markerId: MarkerId('knocks'),
    position: LatLng(-26.17825,28.035),
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
    position: LatLng(-26.1919,28.0336),
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
    infoWindow: InfoWindow(title: 'Wits Junction')
    ),

        }
      ),

    );
  }


}

