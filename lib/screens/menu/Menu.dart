import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:wits_bus/screens/student_screen/drawer.dart';
import 'package:wits_bus/services/auth.dart';

class Menu extends StatefulWidget {

  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  final AuthService _auth = AuthService();

  void signOut() {
    _auth.signOut();
  }

  void goToProfilePage() {
    //pop menu drawer

    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/profile');

  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {



    return  Scaffold(
      backgroundColor: Colors.grey[40],
           appBar: AppBar(title: Text('Menu'),), drawer: MyDrawer(
          onProfileTap: goToProfilePage,
           onSignOut: signOut,
    ),
             body:

             Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children :  [
                    Row(
                      children : [
                    GestureDetector(child: _buildAvatarWithShadow('assets/schedule.jpg'), onTap: () => Navigator.pushReplacementNamed(context, '/schedule'),) ,
                    SizedBox(width: 20,),

                    GestureDetector(child: _buildAvatarWithShadow('assets/map.png'), onTap: () => Navigator.pushReplacementNamed(context, '/map'),)
                 ]
                    ),

                    SizedBox(height: 40,),

                    GestureDetector(child: _buildAvatarWithShadow('assets/time.jpg') , onTap: () => Navigator.pushReplacementNamed(context, '/timer'), )

                  ]

                ),


                ),


    );
  }

  Widget _buildAvatarWithShadow(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 90,
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }
}




