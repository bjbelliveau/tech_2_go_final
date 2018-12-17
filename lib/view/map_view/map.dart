import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tech_2_go_final/utilities/widget_utils.dart'
    show screenAwareSize;

class LpiMap extends StatefulWidget {
  @override
  _LpiMapState createState() => _LpiMapState();
}

class _LpiMapState extends State<LpiMap> {
  final LatLng center = const LatLng(39.809734, -92.555620);

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
                  MarkerOptions rhinelander = MarkerOptions(
                      position: LatLng(45.621125, -89.478187),
                      infoWindowText:
                          InfoWindowText("Home Office", 'Rhinelander, WI'));
                  MarkerOptions txdc = MarkerOptions(
                      position: LatLng(32.5548476, -94.29555959999999),
                      infoWindowText:
                          InfoWindowText("Texas Office", 'Marshall, TX'));
                  MarkerOptions ecdc = MarkerOptions(
                      position: LatLng(39.9121765, -77.66361069999999),
                      infoWindowText:
                          InfoWindowText("East Office", 'Chambersburg, PA'));
                  MarkerOptions wcdc = MarkerOptions(
                      position: LatLng(36.054243, -115.02041750000001),
                      infoWindowText:
                          InfoWindowText("West Office", 'Henderson, NV'));

                  controller.addMarker(rhinelander);
                  controller.addMarker(txdc);
                  controller.addMarker(ecdc);
                  controller.addMarker(wcdc);
                },
                options: GoogleMapOptions(
                  trackCameraPosition: true,
//                  minMaxZoomPreference: MinMaxZoomPreference(screenAwareSize(2.5, context), 5.0),
                  cameraPosition: CameraPosition(
                      target: center, zoom: screenAwareSize(3.1, context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
