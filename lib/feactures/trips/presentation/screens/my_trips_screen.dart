import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/my_trips_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/headers/custom_top_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyTripsSCreen extends StatelessWidget {
  const MyTripsSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, 
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
      ),
      body: const _BodyTripsInfo(),
    );
  }
}

class _BodyTripsInfo extends ConsumerWidget {
  const _BodyTripsInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myTripsData = ref.watch(myTripProvider);

    return myTripsData.when(
      data: (myTrips) => SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const CustomTopHeader(
                titleHeader: 'Mis viajes realizados',
                icon: Icons.pedal_bike_outlined,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: myTrips.items.map((viaje) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text('Viaje: N° ${viaje.id}'),
                          leading: const Icon(Icons.directions_bike_rounded),
                          subtitle: Text(
                              '${viaje.estacionInicioId} - ${viaje.estacionFinalId ?? "En curso"}'),
                          trailing: Text('Duracion: ${viaje.duracion}'),
                          isThreeLine: false,
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Viaje: N° 1',
                      ),
                      leading: Icon(Icons.directions_bike_rounded),
                      subtitle: Text('Nodo tecnologico - Plaza 25 de mayo'),
                      trailing: Text('20/04/2024'),
                      isThreeLine: false,
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Viaje: 20/04/2024',
                      ),
                      leading: Icon(Icons.directions_bike_rounded),
                      subtitle: Text('Nodo tecnologico - Plaza 25 de mayo'),
                      // trailing: Text('20/04/2024'),
                      isThreeLine: false,
                    ),
                    Divider(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error al cargar viajes, pruebe mas tarde')),
    );
  }
}
