import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_config/flutter_config.dart';


void getKey () async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
}

class Student_Home extends StatefulWidget {
  const Student_Home({super.key});

  @override
  State createState() => _Student_HomeState();
}




class _Student_HomeState extends State {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-26.1783, 28.0355);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  void initState() {
    // TODO: implement initState
    getKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bus Location'),
          backgroundColor: Colors.blue[700],
            leading:IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pushReplacementNamed(context, '/Login') ;},)
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 17.0,
          ),
        ),
      ),
    );
  }
}