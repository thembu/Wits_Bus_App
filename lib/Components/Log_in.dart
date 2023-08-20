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

      appBar:AppBar( title : Text('Bus tracking app' ),
          centerTitle : true,

      ),

      body:
      Flex (
      direction: Axis.vertical,
      children : [

      Padding(

        padding: const EdgeInsets.fromLTRB(100, 100, 100, 0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            GestureDetector(

              child :
            CircleAvatar(
              radius: 150,
              backgroundImage: AssetImage('assets/driver.jpg'),
            ),
              onTap: () {
                    Navigator.pushReplacementNamed(context, 'Student_Track');}
            )

          ],
        ),
      ),
    ]
      ),



    );
  }
}
