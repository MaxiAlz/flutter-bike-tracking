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
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.pedal_bike, color: colors.primary),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Text(
                      'Bicicletas disponibles:',
                      style: TextStyle(color: colors.primary),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20)),
                    Text('Electricas: ${marker.cantidadElectrica}'),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20)),
                    Text('Mecanicas: ${marker.cantidadMecanica}'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.local_parking_rounded, color: colors.primary),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Text(
                      'Capacidad total:',
                      style: TextStyle(color: colors.primary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20)),
                    Text('Electricas: ${marker.capacidadElectricas}'),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20)),
                    Text('Mecanicas: ${marker.capacidadMecanicas}'),
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
