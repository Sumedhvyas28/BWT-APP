import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class mapPage extends StatefulWidget {
  const mapPage({super.key});

  @override
  State<mapPage> createState() => _mapPageState();
}

class _mapPageState extends State<mapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDashApp(title: 'Location'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(10.725512, 106.723733),
                initialZoom: 10,
                interactionOptions:
                    InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
              ),
              children: [
                openStreetMapTileLayer,
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(10.725512, 106.723733),
                      width: 60,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.location_pin,
                        size: 60,
                      ),
                    ),
                    Marker(
                      point: LatLng(10.738016, 106.790482),
                      width: 60,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red[900],
                        size: 60,
                      ),
                    ),
                    Marker(
                      point: LatLng(10.718016, 106.960482),
                      width: 60,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red[900],
                        size: 60,
                      ),
                    ),
                    Marker(
                      point: LatLng(10.778016, 106.660482),
                      width: 60,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red[900],
                        size: 60,
                      ),
                    ),
                    Marker(
                      point: LatLng(10.719016, 106.660482),
                      width: 60,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red[900],
                        size: 60,
                      ),
                    ),
                    Marker(
                      point: LatLng(10.758016, 106.890482),
                      width: 60,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red[900],
                        size: 60,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
