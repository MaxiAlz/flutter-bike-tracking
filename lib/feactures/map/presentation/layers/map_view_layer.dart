// import 'package:app_ciudadano_vc/shared/infraestructure/services/geolocation/geolocation_service_impl.dart';
import 'package:app_ciudadano_vc/feactures/home/presentation/home_presentation.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/layers/marker_dialog_hub.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/providers/hubs_provider.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/providers/map_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapViewLayer extends ConsumerWidget {
  const MapViewLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSettings = ref.watch(mapSettingProvider);
    final markerDialogHub = MarkerDialogHub();
    final mapController = MapController();
    final hubList = ref.watch(hubListProvider);

    print('===>::hubList::==> $hubList');

    // getUserPosition() {
    //   final position = ref.read(mapSettingProvider.notifier).getUserPosition();
    //   print('&&&position&&& : $position');
    // }

    return hubList.when(
      data: (listOfHubs) => FlutterMap(
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
          // MarkerLayer(markers: [
          //   Marker(
          //       point: LatLng(mapSettings.userPosition.latitude,
          //           mapSettings.userPosition.longitude),
          //       child: const Icon(
          //         Icons.location_on,
          //         color: Colors.red,
          //       ))
          // ]),

          MarkerLayer(
            markers: hubList.value!
                .map(
                  (marker) => Marker(
                      point:
                          LatLng(marker.ubicacion.lat, marker.ubicacion.long),
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
      ),
      loading: () {
        // Mientras se está cargando la lista de hubs, puedes mostrar un indicador de carga
        return const CircularProgressIndicator();
      },
      error: (error, stackTrace) {
        // Si ocurre un error durante la carga de la lista de hubs, puedes manejarlo aquí
        return Text('Error al cargar la lista de hubs: $error');
      },
    );
  }
}
