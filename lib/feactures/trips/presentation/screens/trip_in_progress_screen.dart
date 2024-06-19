import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/feactures/trips/trips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
TODO:
 Ver a logica de mantener el contador cuando el usuario cierra la sesion
 cambiar en el backen el estado del usuario a "en viaje" cuando se acepte el viaje


  
 */

class TripInProgressScreen extends ConsumerWidget {
  const TripInProgressScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final tripProvider = ref.watch(tripNotifierProvider);
    // final colors = Theme.of(context).colorScheme;
    // final subtitlesStyle = Theme.of(context).textTheme.titleMedium;
    // final userDataAuthenticated = ref.watch(authProvider).user;
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return _buildContent(
          tripStatus: tripProvider.tripStatus,
          tripProvider: tripProvider,
        );
      }),
    );
  }

  Widget _buildContent({required TripStatus tripStatus, tripProvider}) {
    switch (tripStatus) {
      case TripStatus.inProgress:
        return const TripInProgress();
      case TripStatus.finished:
        return const TripEnded();
      case TripStatus.pending:
        return const TripPending(); // Opcional: muestra un indicador de carga mientras se espera el estado del viaje
      case TripStatus.failed:
        return const Center(child: Text('El viaje ha fallado.'));
      case TripStatus.notTravelling:
      default:
        return const Center(
            child: Text('Ah ocurrido un error esperando el estado del viaje'));
    }
  }
}
