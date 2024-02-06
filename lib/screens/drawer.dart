import 'package:flutter/material.dart';
import 'package:wits_bus/screens/my_list_tile.dart';

class MyDrawer extends StatelessWidget {

  final void Function()? onProfileTap;
  final void Function()? onSignOut;

  const MyDrawer({super.key, required this.onProfileTap , required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.blue,
      child: Column(
        children: [
          // header

          DrawerHeader(child: Icon(Icons.person ,  color: Colors.white, size: 64,)),

          //Home List tile

          MyListTile(
              icon: Icons.home,
              text: 'H O M E',
              onTap: () => Navigator.pushReplacementNamed(context, '/menu'),
          ),


          // profile list tile

          MyListTile(icon: Icons.person, text: 'P R O F I L E', onTap: onProfileTap),

          // Log out list tile

          MyListTile(icon: Icons.logout, text: 'L O G O U T', onTap: onSignOut)

          // input list tile
        ],
      ),
    );
  }
}
