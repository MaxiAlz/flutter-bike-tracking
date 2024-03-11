// import 'package:app_ciudadano_vc/shared/infraestructure/services/geolocation/geolocation_service_impl.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/geolocation/markers_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
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
          markers: marcadores
              .map(
                (e) => Marker(
                  point: e,
                  width: 50.0, // Use double for width and height
                  height: 50.0,
                  child: Icon(
                    Icons.location_on,
                    color: colors.primary,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

// class MapViewLayer extends StatefulWidget {
//   const MapViewLayer({super.key});

//   @override
//   State<MapViewLayer> createState() => _MapViewLayerState();
// }

// class _MapViewLayerState extends State<MapViewLayer> {
//   final geolocalizationServiceImpl = GeolocationImpl();
//   late Future<Position> _initialLocation;

//   @override
//   void initState() {
//     super.initState();

//     _initialLocation = geolocalizationServiceImpl
//         .getCurrentLocation(); // Call your service here
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final colors = Theme.of(context).colorScheme;

//     return FutureBuilder<Position>(
//       future: _initialLocation,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           // Use the retrieved location to set initialCenter
//           return FlutterMap(
//             mapController: MapController(),
//             options: MapOptions(
//               initialZoom: 13.0,
//               initialCenter:
//                   LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//               ),
//               // ... rest of your layers (CircleLayer, MarkerLayer)
//             ],
//           );
//         } else if (snapshot.hasError) {
//           print(snapshot.error); // Handle location errors
//           return Center(child: Text('Error getting location'));
//         }

//         // Show a loading indicator while location is being fetched
//         return Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }
