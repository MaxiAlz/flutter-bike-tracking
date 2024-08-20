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
      body: const Column(
        children: [
          CustomTopHeader(
            titleHeader: 'Mis viajes realizados',
            icon: Icons.pedal_bike_outlined,
          ),
          _BodyTripsInfo(),
        ],
      ),
    );
  }
}

class _BodyTripsInfo extends ConsumerWidget {
  const _BodyTripsInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myTripsData = ref.watch(myTripProvider);

    return myTripsData.when(
      data: (myTrips) => myTrips.items.isEmpty
          ? const Center(child: Text('No hay viajes'))
          : Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(myTripProvider.future),
                child: ListView.builder(
                  itemCount:
                      myTrips.items.length, // +1 para incluir el encabezado
                  itemBuilder: (context, index) {
                    final viaje = myTrips.items[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text('Viaje: N° ${viaje.id}'),
                          leading: const Icon(Icons.directions_bike_rounded),
                          subtitle: Row(
                            children: [
                              Text(viaje.estacionInicioNombre),
                              const Icon(Icons.moving_rounded),
                              Text(viaje.estacionFinalNombre ?? "En curso"),
                            ],
                          ),
                          trailing: Text('Duración: ${viaje.duracion} min'),
                          isThreeLine: false,
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) =>
          Center(child: Text('Error al cargar viajes: $err')),
    );
  }
}
