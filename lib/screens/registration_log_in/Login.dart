
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wits_bus/screens/menu/Loading.dart';
import 'package:wits_bus/services/auth.dart';
import 'package:wits_bus/wrapper.dart';
import 'package:location/location.dart';

class Log_in extends StatefulWidget {


  static var user_latitude ;
  static var user_longitude;

  final Function toggleView;

  Log_in({required this.toggleView});



  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {


  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email ='';
  String password = '';
  String error = '';
  bool loading  = false;


  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
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
                  backgroundImage: AssetImage('assets/kudus.png'),
                  backgroundColor: Colors.white,
                ),

                SizedBox(height: 10,),
                Text(
                  'Welcome back',
                  style: GoogleFonts.bebasNeue(fontSize: 52),
                ),

                SizedBox(height: 10,),
                Text(
                  'Log in with student email ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                          onChanged: (val) => setState(() {
                            email = val;
                          }),
                          decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'email'
                        ),

                      ),
                    ),

                  ),
                ),


               SizedBox(height: 10,),

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
                          validator: (val) => val!.length < 6 ? 'Enter a password of 6+ characters' : null,
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


                SizedBox(height: 10,),

                Padding(
                  padding:  EdgeInsets.all(25.0),
                  child: ElevatedButton(
                    onPressed: () async {


                        if(!email.contains("@students.wits.ac.za")) {
                          Wrapper.student = false;
                        } else if(!email.contains("@wits.ac.za")) {
                          Wrapper.student = true;
                        }

                        dynamic result = await _auth.signIn(email, password);
                        if(_formKey.currentState!.validate() && result != null) {
                          setState(() {
                            loading = true;
                          });
                        print(loading);

                        if(result == null) {
                          setState(() {
                            loading = false;
                            error = 'wrong credentials';
                          });
                        }

                        print(loading);

                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: Size(200, 50)
                    ),


                    child: Text('sign in', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),),
                  ),

                ),

                Text(error , style: TextStyle(color: Colors.red , fontSize: 14),),

                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('not a member ? ' , style: TextStyle(fontWeight: FontWeight.bold),),
                    GestureDetector(
                        child:
                          Text('Register now',
                          style: TextStyle(
                              color: Colors.blue ,
                            fontWeight: FontWeight.bold,
                          ),),
                      onTap: () async{

                           widget.toggleView();


                      },
                    )
                  ],
                ),

                SizedBox(height: 10,),

                Padding(

                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('or continue with', style: TextStyle(
                    color: Colors.grey[700]
                  ),),

                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[200],
                        ),
                        child:
                        GestureDetector(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/google.png') ,
                            radius: 35,),
                          onTap: () async{
                                 _auth.Sign_in_google();

                          }
                          ,
                        )
                    ),

                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }


}









