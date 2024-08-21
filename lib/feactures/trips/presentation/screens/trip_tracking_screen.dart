import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/widgets/trip_failed.dart';
import 'package:app_ciudadano_vc/feactures/trips/trips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripTrackingScreen extends ConsumerWidget {
  const TripTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final tripProvider = ref.watch(tripNotifierProvider);
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return _buildContent(
          tripStatus: tripProvider.tripStatus,
        );
      }),
    );
  }

  Widget _buildContent({
    required TripStatus tripStatus,
  }) {
    switch (tripStatus) {
      case TripStatus.notTravelling:
        return const EnterBikePatentScreen();
      case TripStatus.  pending:
        return const TripPending();
      case TripStatus.inProgress:
        return const TripInProgress();
      case TripStatus.finished:
        return const TripEnded();
      case TripStatus.failed:
        return const TripRequestFailed();
      case TripStatus.denied:
        return const TripDenied();
      default:
        return const Center(
            child: Text('Ha ocurrido un error esperando el estado del viaje'));
    }
  }
}
