import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class mapPage extends StatefulWidget {
  final Map<String, dynamic>? task;

  const mapPage({super.key, this.task});

  @override
  State<mapPage> createState() => _mapPageState();
}

class _mapPageState extends State<mapPage> {
  Map<String, dynamic>? taskData;
  double? lat2;
  double? lon2;
  bool isLoading = true;

  @override
  void initState() {
    taskData = widget.task;
    fetchTaskData();
    super.initState();
  }

  Future<void> fetchTaskData() async {
    try {
      final currentLocation = await _getCurrentLocation();
      setState(() {
        lat2 = currentLocation['latitude'];
        lon2 = currentLocation['longitude'];
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching current location: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _openGoogleMaps(double latitude, double longitude) async {
    final Uri googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );

    try {
      // Attempt to launch Google Maps (if installed)
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Fallback to browser if Google Maps is not available
      final Uri fallbackUrl = Uri.parse(
          "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
      await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lat1 = taskData?['geolocation']['features'][0]['geometry']
            ['coordinates'][1] ??
        0.0;
    final long1 = taskData?['geolocation']['features'][0]['geometry']
            ['coordinates'][0] ??
        0.0;

    print("Lat2: $lat2, Lon2: $lon2");

    if (isLoading) {
      return Scaffold(
        appBar: CustomDashApp(title: 'Location'),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomDashApp(title: 'Location'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(lat1, long1),
                initialZoom: 18,
                interactionOptions:
                    InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
              ),
              children: [
                openStreetMapTileLayer,
                MarkerLayer(
                  markers: [
                    if (lat2 != null && lon2 != null)
                      Marker(
                        point: LatLng(lat2!, lon2!),
                        width: 60,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.black,
                          size: 60,
                        ),
                      ),
                    Marker(
                      point: LatLng(lat1, long1),
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
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () => _openGoogleMaps(lat1, long1),
                child: Icon(Icons.map),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, double>> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
