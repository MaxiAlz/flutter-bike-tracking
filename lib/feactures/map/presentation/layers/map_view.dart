import 'package:app_ciudadano_vc/feactures/home/presentation/home_presentation.dart';
import 'package:app_ciudadano_vc/feactures/map/domain/entities/hub_entiti.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/map_presentation.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/providers/map_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  const MapView({
    super.key,
    required this.mapController,
    required this.mapSettings,
    required this.hubList,
    required this.markerDialogHub,
  });

  final MapController mapController;
  final MapSettingState mapSettings;
  final AsyncValue<List<Hub>> hubList;
  final MarkerDialogHub markerDialogHub;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: const MapOptions(
        initialZoom: 13,
        initialCenter: LatLng(-28.460501, -65.780756),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          // Plenty of other options available!
        ),
        // const CircleLayer(
        //   circles: [
        //     CircleMarker(
        //         point: LatLng(-28.476765, -65.787757),
        //         radius: 30,
        //         useRadiusInMeter: true,
        //         color: Color.fromARGB(139, 33, 149, 243)),
        //   ],
        // ),
        Container(
          alignment: Alignment.topRight,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
              child: MyLocationButton(
                mapController: mapController,
                mapSetting: mapSettings,
              )),
        ),
        MarkerLayer(markers: [
          Marker(
              point: LatLng(mapSettings.userPosition.latitude,
                  mapSettings.userPosition.longitude),
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
              ))
        ]),

        MarkerLayer(
          markers: hubList.value!
              .map(
                (marker) => Marker(
                    point: LatLng(marker.ubicacion.lat, marker.ubicacion.long),
                    width: 50.0, // Use double for width and height
                    height: 50.0,
                    child: IconButton.filled(
                        onPressed: () =>
                            markerDialogHub.onMarkerTap(context, marker),
                        icon: const Icon(Icons.store_mall_directory))),
              )
              .toList(),
        ),
      ],
    );
  }
}
