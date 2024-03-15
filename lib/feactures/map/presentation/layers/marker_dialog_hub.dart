import 'package:flutter/material.dart';


// tambien podria ser una carpeta de util osea => MarkersUtil y crear todos los metodos aca
class MarkerDialogHub {
  void onMarkerTap(BuildContext context, marker) {
    final colors = Theme.of(context).colorScheme;
    final subTitleStyle = Theme.of(context).textTheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.store_outlined,
                    color: colors.primary,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Column(
                    children: [
                      Text(
                        '${marker.title}',
                        style: subTitleStyle.titleMedium,
                      ),
                      Text(
                        '${marker.description}',
                        style: subTitleStyle.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                child: Divider(),
              )
            ],
          ),
          content: Row(
            children: [
              const Icon(Icons.pedal_bike_rounded),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10)),
              Text('Bicicletas disponibles: ${marker.availableBikes}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
