
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wits_bus/screens/Loading.dart';

import '../services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String password = '';
  String email = '';
  String error = '';
  dynamic result;
  bool loading = false;


  @override
  Widget build(BuildContext context) {


    return loading ? Loading() : Scaffold(
     resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body:  SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/wallpaper.jpeg'),
                ),

                SizedBox(height: 10,),
                Text(
                  'Register here',
                  style: GoogleFonts.bebasNeue(fontSize: 52),
                ),


                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        validator: (val)  {
                          if(!val!.contains("@students.wits.ac.za") && !val.contains("@wits.ac.za") ) {
                            return 'Use student or driver email';
                          }

                          return null;

                        },

                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },

                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'email'
                        ),

                      ),
                    ),

                  ),
                ),



                SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                       validator: (val) => val!.length < 6 ? 'Enter a password 6+ characters long ' : null,
                       onChanged: (val) {
                         setState(() {
                           password = val;
                         });
                       },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'password'
                        ),

                      ),
                    ),

                  ),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        validator: (val) => val != password ? 'Password must match' : null,

                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ' confirm password'
                        ),

                      ),
                    ),

                  ),
                ),


                SizedBox(height: 20,),

                Padding(
                  padding:  EdgeInsets.all(25.0),
                  child: ElevatedButton(
                    onPressed: () async{
                      if(_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        if(email.contains("@wits.ac.za")) {
                           result = await _auth.registerDriver(email, password);
                        }
                        else if (email.contains("@students.wits.ac.za")) {
                          result = await _auth.registerUser(email, password);
                        }
                        if(result ==  null) {
                          setState(() => error = 'please supply a valid email');
                          loading = false;
                        }

                        widget.toggleView();
                      }


                    },

                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        minimumSize: Size(200, 50)
                    ),




                    child: Text('Register', style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                  ),


                ),

                Text(
                  error,
                  style: TextStyle(color : Colors.red , fontSize: 14),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}









