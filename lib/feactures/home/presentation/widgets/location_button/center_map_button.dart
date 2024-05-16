import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CenterMapButton extends StatelessWidget {
  final MapController mapController;
  const CenterMapButton({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return IconButton.filledTonal(
      onPressed: () {
        mapController.move(
          const LatLng(-28.460501, -65.780756),
          12.5,
        );
      },
      icon: Icon(
        Icons.zoom_in_map_rounded,
        color: colors.primary,
      ),
    );
  }
}
