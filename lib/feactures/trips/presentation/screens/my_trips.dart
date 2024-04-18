import 'package:app_ciudadano_vc/shared/widgets/headers/custom_top_header.dart';
import 'package:flutter/material.dart';

class MyTripsSCreen extends StatelessWidget {
  const MyTripsSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final subtitlesStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Color blanco para el icono de retroceso
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        title: Text(
          'Mis viajes',
          style: subtitlesStyle!.copyWith(fontSize: 18, color: Colors.white),
        ),
      ),
      body: const _BodyTripsInfo(),
    );
  }
}

class _BodyTripsInfo extends StatelessWidget {
  const _BodyTripsInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Column(children: [
          CustomTopHeader(
            titleHeader: 'Historial de viajes',
            icon: Icons.pedal_bike_outlined,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Viaje: N° 1',
                  ),
                  leading: const Icon(Icons.directions_bike_rounded),
                  subtitle: const Text('Nodo tecnologico - Plaza 25 de mayo'),
                  trailing: Text('20/04/2024'),
                  isThreeLine: false,
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Viaje: 20/04/2024',
                  ),
                  leading: const Icon(Icons.directions_bike_rounded),
                  subtitle: const Text('Nodo tecnologico - Plaza 25 de mayo'),
                  // trailing: Text('20/04/2024'),
                  isThreeLine: false,
                ),
                Divider(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
