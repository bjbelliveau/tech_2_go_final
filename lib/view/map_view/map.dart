import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LpiMap extends StatefulWidget {
  @override
  _LpiMapState createState() => _LpiMapState();
}

class _LpiMapState extends State<LpiMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Column(
       children: <Widget>[
         Container(
           height: 250.0,
           width: 250.0,
           child: GoogleMap(onMapCreated: (GoogleMapController controller){

           }),
         ),
       ],
      ),
    );
  }
}