import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapViewLayer extends StatelessWidget {
  const MapViewLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: MapController(),
      options: const MapOptions(
        initialZoom: 10,
        initialCenter: LatLng(-28.460501, -65.780756),

        // initialCameraFit: CameraFit.coordinates(coordinates: )
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          // Plenty of other options available!
        ),
      ],
    );
  }
}
