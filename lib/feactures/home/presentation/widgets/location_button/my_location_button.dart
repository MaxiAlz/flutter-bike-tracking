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

    return IconButton.filledTonal(
      onPressed: mapSetting.isLoadingPositions
          ? null
          : () async {
              final position = await ref
                  .watch(mapSettingProvider.notifier)
                  .getUserPosition();

              ref.read(mapSettingProvider).copyWith(userPosition: position);
              mapController.move(
                  LatLng(position.latitude, position.longitude), 15);
            },
      icon: mapSetting.isLoadingPositions
          ? const CircularProgressIndicator()
          : Icon(
              Icons.my_location,
              color: colors.primary,
            ),
    );
  }
}
