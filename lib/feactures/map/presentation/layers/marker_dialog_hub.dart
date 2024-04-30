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
          elevation: 20,
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
                        '${marker.nombre}',
                        style: subTitleStyle.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '${marker.direccion}',
                style: subTitleStyle.bodySmall,
              ),
              const SizedBox(
                child: Divider(),
              )
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.directions_bike),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Text(
                        'Bicicletas disponibles: ${marker.cantidadBicicletas}'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(Icons.electric_bike_outlined),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Text('Electricas: ${marker.capacidadElectrica}'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(Icons.pedal_bike_outlined),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Text('Mecanicas: ${marker.capacidadMecanica}'),
                  ],
                ),
              ],
            ),
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
