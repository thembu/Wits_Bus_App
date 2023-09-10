import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wits_bus/screens/Driver_Load.dart';
import 'package:wits_bus/screens/Student_Home.dart';
import 'package:wits_bus/services/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bus tracking app',
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _auth.signOut();
              },
              icon: Icon(Icons.person , size: 40,),

          ),
              
        ],
      ),
      backgroundColor: Colors.grey[300],
      body:

      Flex(direction: Axis.vertical, children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Text(
          'Are you a driver or Student ?',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 250, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/driver.jpg'),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:  (context) => Driver_Load()));
                  }),
              VerticalDivider(
                width: 3,
              ),
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/student.png'),
                  ),
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Student_Home()));
                  })
            ],
          ),
        ),
      ]),
    );
  }
}
