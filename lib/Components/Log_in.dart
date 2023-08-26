import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Log_in extends StatefulWidget {
  const Log_in({super.key});

  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {

  late TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    _textEditingController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    return  Scaffold(

      appBar:AppBar( title : Text('Bus tracking app' ,),
          centerTitle : true,

      ),

      body:
      Flex (
      direction: Axis.vertical,
      children : <Widget>[
      SizedBox(height: 50,)  ,
      Text('Are you a driver or Student ?',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      Padding(

        padding: const EdgeInsets.fromLTRB(50, 250, 50, 0),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[


             GestureDetector(

              child :
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/driver.jpg'),
            ),
              onTap: () {
                    Navigator.pushReplacementNamed(context, 'Driver_Load');}
            ),

            VerticalDivider(width: 3,),
            SizedBox(width: 30,),
            GestureDetector(

                child :
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/student.png'),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'Student_Home');}
            )




          ],
        ),
      ),
    ]
      ),



    );
  }
}
