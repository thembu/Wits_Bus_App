import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('profile page'), leading: IconButton(icon :Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pushReplacementNamed(context, '/menu'),),),


      body: ListView(
        children: [

          const SizedBox(height: 50,),

          //profile


          Icon(Icons.person , size: 72, color: Colors.blue,),

          // user email

          Text('${currentUser?.email}', textAlign: TextAlign.center,)



          // name

          //  current location

          //
        ],
      ),

    );
  }
}
