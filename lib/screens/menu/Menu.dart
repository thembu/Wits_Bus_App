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
           appBar: AppBar(title: Text('Menu'),), drawer: MyDrawer(
      onProfileTap: goToProfilePage,
      onSignOut: signOut,
    ),
             body: Container(
                 color: Colors.grey[0],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,200, 20, 200),
                  child: GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10), children: [
                    GestureDetector(child: Container(foregroundDecoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/schedule.jpg'),fit: BoxFit.fill),borderRadius: BorderRadius.circular(20))), onTap: (){
                      Navigator.pushReplacementNamed(context, '/schedule');
                    },),
                    GestureDetector(child: Container(foregroundDecoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/wallpaper.jpeg'), fit: BoxFit.fill),borderRadius: BorderRadius.circular(20))),onTap: () {
                      Navigator.pushReplacementNamed(context, '/map');
                    },),

                  ]),
                ),
            ),

    );
  }
}
