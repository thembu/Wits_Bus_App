import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Bus_Schedule extends StatefulWidget {
  const Bus_Schedule({super.key});

  @override
  State<Bus_Schedule> createState() => _Bus_ScheduleState();
}

class _Bus_ScheduleState extends State<Bus_Schedule> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Bus Schedule"),leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/menu')
          ;
        },
      ),),
      body: SfPdfViewer.asset('assets/General Campus Bus Schedule - Published on 21 April 2023.pdf'),
    );
  }
}
