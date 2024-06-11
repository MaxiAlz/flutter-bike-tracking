import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/loaders/full_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripPending extends ConsumerWidget {
  const TripPending({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripProvider = ref.watch(tripNotifierProvider).tripData;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            child: FullLoader(
              label: 'Esperando aprovacion',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child:
                Text('Tu solicitud de viaje es la N° ${tripProvider?.viajeId}'),
          ),
        ],
      ),
    );
  }
}
