import 'package:app_ciudadano_vc/feactures/home/presentation/home_presentation.dart';
import 'package:app_ciudadano_vc/feactures/map/domain/entities/hub_entiti.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/map_presentation.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/providers/map_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class MapView extends ConsumerWidget {
  const MapView({
    super.key,
    required this.mapController,
    required this.hubList,
    required this.markerDialogHub,
  });

  final MapController mapController;

  final AsyncValue<List<Hub>> hubList;
  final MarkerDialogHub markerDialogHub;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSettings = ref.watch(mapSettingProvider);

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
        Container(
          alignment: Alignment.topRight,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: 48,
                height: 48,
                child: MyLocationButton(
                  mapController: mapController,
                  mapSetting: mapSettings,
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  width: 48,
                  height: 48,
                  child: CenterMapButton(mapController: mapController)),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: 48,
                height: 48,
                child: IconButton.filled(
                    onPressed: () {
                      context.push('/trip-in-progress');
                    },
                    icon: Icon(Icons.pedal_bike)),
              )
            ],
          ),
        ),
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
        MarkerLayer(markers: [
          Marker(
            point: LatLng(mapSettings.userPosition.latitude,
                mapSettings.userPosition.longitude),
            width: 50.0, // Use double for width and height
            height: 50.0,
            child: IconButton(
                color: Colors.red,
                onPressed: () {},
                icon: const Icon(
                  Icons.location_on,
                  size: 40,
                  shadows: [Shadow(blurRadius: 10)],
                )),
          )
        ]),
      ],
    );
  }
}
