import 'package:app_ciudadano_vc/feactures/map/presentation/providers/map_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class MyLocationButton extends ConsumerWidget {
  final MapController mapController;
  final MapSettingState mapSetting;
  const MyLocationButton({
    required this.mapController,
    super.key,
    required this.mapSetting,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    // final mapSetting = ref.watch(mapSettingProvider);

    print('mapSetting.userPosition: ${mapSetting.userPosition}');

    return IconButton.filledTonal(
        onPressed: () async {
          await ref.read(mapSettingProvider.notifier).updateLocation();
          final position = mapSetting.userPosition;
          mapController.move(LatLng(position.latitude, position.longitude), 20);
        },
        icon: Icon(
          Icons.my_location,
          color: colors.primary,
        ));
  }
}
