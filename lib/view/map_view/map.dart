import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LpiMap extends StatefulWidget {
  @override
  _LpiMapState createState() => _LpiMapState();
}

class _LpiMapState extends State<LpiMap> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text('Map'),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  appBar.preferredSize.height,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  List<double> rhinelander = [45.621125, -89.478187];
                  List<double> txdc = [32.5548476, -94.29555959999999];
                  List<double> ecdc = [39.9121765, -77.66361069999999];
                  List<double> wcdc = [36.054243, -115.02041750000001];

                  controller.addMarker(
                    MarkerOptions(
                      position: LatLng(rhinelander[0], rhinelander[1]),
                      infoWindowText:
                          InfoWindowText("Home Office", 'Rhinelander, WI'),
                    ),
                  );
                  controller.addMarker(
                    MarkerOptions(
                      position: LatLng(txdc[0], txdc[1]),
                      infoWindowText:
                          InfoWindowText("Texas Office", 'Marshall, TX'),
                    ),
                  );
                  controller.addMarker(
                    MarkerOptions(
                      position: LatLng(ecdc[0], ecdc[1]),
                      infoWindowText:
                          InfoWindowText("East Office", 'Chambersburg, PA'),
                    ),
                  );
                  controller.addMarker(
                    MarkerOptions(
                      position: LatLng(wcdc[0], wcdc[1]),
                      infoWindowText:
                          InfoWindowText("West Office", 'Henderson, NV'),
                    ),
                  );
                },
                options: GoogleMapOptions(
                  minMaxZoomPreference: MinMaxZoomPreference(3.1, 5.0),
                  cameraPosition:
                      CameraPosition(target: LatLng(39.809734, -92.555620)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
