import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapViewLayer extends StatelessWidget {
  const MapViewLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return FlutterMap(
      mapController: MapController(),
      options: const MapOptions(
        initialZoom: 13,
        initialCenter: LatLng(-28.460501, -65.780756),

        // initialCameraFit: CameraFit.coordinates(coordinates: )
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          // Plenty of other options available!
        ),
        const CircleLayer(
          circles: [
            CircleMarker(
                point: LatLng(-28.476765, -65.787757),
                radius: 30,
                useRadiusInMeter: true,
                color: Color.fromARGB(139, 33, 149, 243)),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: const LatLng(-28.476765, -65.787757),
              width: 50,
              height: 50,
              child: Icon(
                Icons.location_on,
                color: colors.primary,
              ),
            ),
            Marker(
              point: const LatLng(-28.460397, -65.767009),
              width: 50,
              height: 50,
              child: Icon(
                Icons.location_on,
                color: colors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
