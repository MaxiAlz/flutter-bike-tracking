import 'dart:async';

import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/screens/map_view_layer.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripInProgressScreen extends ConsumerWidget {
  const TripInProgressScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final colors = Theme.of(context).colorScheme;
    // final subtitlesStyle = Theme.of(context).textTheme.titleMedium;
    // final userDataAuthenticated = ref.watch(authProvider).user;
    return Scaffold(
      body: _BodyTripInProgress(),
    );
  }
}

class _BodyTripInProgress extends StatefulWidget {
  const _BodyTripInProgress({
    super.key,
  });

  @override
  __BodyTripInProgressState createState() => __BodyTripInProgressState();
}

class __BodyTripInProgressState extends State<_BodyTripInProgress> {
  Duration tripDuration = const Duration();
  Timer? timer;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (!isPaused) {
        setState(() {
          tripDuration += const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void endTrip() {
    timer?.cancel();
    // Lógica para finalizar el viaje, por ejemplo, navegar a otra pantalla o guardar datos.
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // final subtitlesStyle = Theme.of(context).textTheme.titleMedium;
    return Stack(
      children: [
        const MapViewLayer(),
        DraggableScrollableSheet(
          initialChildSize: 0.2,
          minChildSize: 0.2,
          maxChildSize: 0.3,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Color.fromARGB(255, 241, 241, 241),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Column(
                    children: [
                      Text(
                        'Tu viaje esta en curso:',
                        style: TextStyle(
                            color: colors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${tripDuration.inMinutes}:${(tripDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                        style: TextStyle(
                            color: colors.primary,
                            fontSize: 80,
                            fontWeight: FontWeight.w100),
                      ),
                      CustomFilledButtom(
                          text: 'Solicitar ayuda', onPressed: () {})
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
