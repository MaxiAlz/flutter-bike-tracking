import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/loaders/full_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripPending extends ConsumerWidget {
  const TripPending({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titlesStyles = Theme.of(context).textTheme;
    final tripProvider = ref.watch(tripNotifierProvider).tripData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          child: FullLoader(
            label: 'Esperando aprobacion',
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Un agente debe aceptar tu viaje ',
              style: titlesStyles.titleLarge, textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'El identificador de tu viaje es el  N°: ${tripProvider?.viajeId}. Aguarda a que un agente a cargo inicie tu viaje',
            style: titlesStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
