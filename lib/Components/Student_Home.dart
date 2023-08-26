import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Student_Home extends StatefulWidget {



  const Student_Home({super.key});

  @override
  State<Student_Home> createState() => _Student_HomeState();
}

class _Student_HomeState extends State<Student_Home> {



  static const _initialCameraPosition = CameraPosition(target: LatLng(-26.17825,28.035 ), zoom: 17);

  late GoogleMapController _googleMapController;


  List buses = [
    {'id' : 0 ,  'name' : 'Bus driver 1' , 'route' : 'KNK - EOH - MAIN'},
    {'id' : 0 ,  'name' : 'Bus driver 1' , 'route' : 'KNK - EOH - MAIN'},
    {'id' : 1 ,  'name' : 'Bus driver 2' , 'route' : 'WJ - WEC - MAIN'},
    {'id' : 2 ,  'name' : 'Bus driver 3' , 'route' : 'NSW - AMH - MAIN'},

  ];



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

    addCustomIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
       //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text('Bus Tracker'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back ) ,onPressed: () {Navigator.pushReplacementNamed(context, '/Login');},),

      ),

      body:Stack(

    children : [
      LayoutBuilder(

          builder: (BuildContext context, BoxConstraints constraints) {
           return SizedBox(
             height: constraints.maxHeight/2, //fits map into availabel space
             child: GoogleMap(
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


      }),



      DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      builder: (BuildContext context ,ScrollController scrollController ){
       return Container(
         color: Colors.white,
         child: ListView.builder(
           physics: ClampingScrollPhysics(),
             controller: scrollController,
             itemCount: buses.length,
           itemBuilder: (BuildContext context , int index) {
             final bus = buses[index];

             if(index == 0 ) {
               return Column(
                   children: [
                     SizedBox(width : 50 , child: Divider(thickness: 5,),),
                     Text('Choose bus you want to board')
                   ],
                 );
             }

             return Card(
               margin: EdgeInsets.zero ,
               elevation: 0,
               child: ListTile(
                   onTap: () {},
                   leading: CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/man.png'),),
                   title: Text(bus['name']),
                   trailing: Text(bus['route']),
                 ),
               );
           },
         ) ,
       );
      })
      
   ]
      ),


    );
  }


}

