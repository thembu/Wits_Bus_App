import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Future<void> getKey() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterConfig.loadEnvVariables();

    Navigator.pushReplacementNamed(context, 'Student_Home');

  }

  @override
  void initState() {
    // TODO: implement initState
    getKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(

          child: SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          ),

        )
    );
  }
}
