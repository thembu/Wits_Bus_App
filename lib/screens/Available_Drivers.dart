import 'package:flutter/material.dart';

class Availabe_Drivers extends StatefulWidget {
  const Availabe_Drivers({super.key});

  @override
  State<Availabe_Drivers> createState() => _Availabe_DriversState();
}

class _Availabe_DriversState extends State<Availabe_Drivers> {

  List buses = [
    {'id': 0, 'name': 'Bus driver 1', 'route': 'KNK - EOH - MAIN'},
    {'id': 0, 'name': 'Bus driver 1', 'route': 'KNK - EOH - MAIN'},
    {'id': 1, 'name': 'Bus driver 2', 'route': 'WJ - WEC - MAIN'},
    {'id': 2, 'name': 'Bus driver 3', 'route': 'NSW - AMH - MAIN'},
  ];



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: buses.length,
        itemBuilder: (BuildContext context , int index) {
          final bus = buses[index];

          if(index == 0 ) {
            return Column(
              children: [
                SizedBox(width : 50 , child: Divider(thickness: 5,),),
                Text('Choose bus you want to board')
              ],
            );
          }

          return Card(
            margin: EdgeInsets.zero ,
            elevation: 0,
            child: ListTile(
              onTap: () {},
              leading: CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/man.png'),),
              title: Text(bus['name']),
              trailing: Text(bus['route']),
            ),
          );
        },
      ) ,
    );


}
}
