import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wits_bus/models/Driver.dart';
import 'package:wits_bus/screens/Drivers_tile.dart';

class Availabe_Drivers extends StatefulWidget {
  const Availabe_Drivers({super.key});

  @override
  State<Availabe_Drivers> createState() => _Availabe_DriversState();
}

class _Availabe_DriversState extends State<Availabe_Drivers> {


  var collection = FirebaseFirestore.instance.collection('location');

  late List<Map<String, dynamic>> drivers;
  bool isLoaded = false;

  _increment() async {
    late List<Map<String, dynamic>> tempList = [];

    var data = await collection.get();

    data.docs.forEach((driver) {
      print(driver.data());
      tempList.add(driver.data()); // adds all fields to list
    });

    setState(() {
      drivers = tempList;
      isLoaded = true;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    _increment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.white,
      child: isLoaded ? ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: drivers.length,
        itemBuilder: ( context ,  index) {
          if(index == 0) {
            return Column(
              children: [
                SizedBox(width : 50 , child: Divider(thickness: 5,),),
                Text('Choose bus you want to board')
              ],
            );
          }

          return  Card(
            margin: EdgeInsets.zero ,
            elevation: 0,
            child: ListTile(
              onTap: () {},
              leading: CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/man.png'),),
              title: Text(drivers[index]["name"] ?? "not given"),
              trailing: Text(drivers[index]["route"] ?? "not given"),
            ),
          );;
        },
      )  : Text('no data'),
    );


}
}
