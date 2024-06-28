import 'package:app_ciudadano_vc/feactures/map/presentation/map_presentation.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/share_infraestructure.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class TripInProgress extends ConsumerStatefulWidget {
  const TripInProgress({Key? key}) : super(key: key);

  @override
  _TripInProgressState createState() => _TripInProgressState();
}

class _TripInProgressState extends ConsumerState<TripInProgress> {
  Timer? timer;
  Duration tripDuration = const Duration();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      final tripState = ref.read(tripNotifierProvider);
      if (tripState.startTime.isNotEmpty) {
        final startTime = DateTime.parse(tripState.startTime);
        final now = DateTime.now();
        setState(() {
          tripDuration = now.difference(startTime);
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final tripState = ref.read(tripNotifierProvider);
    final formattedDuration = formatDuration(tripDuration);

    return Stack(
      children: [
        const MapViewLayer(),
        DraggableScrollableSheet(
          initialChildSize: 0.2,
          minChildSize: 0.2,
          maxChildSize: 0.35,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                color: const Color.fromARGB(255, 241, 241, 241),
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
                        'Tu viaje está en curso:',
                        style: TextStyle(
                          color: colors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (int.parse(formattedDuration.hours) > 0)
                            Column(
                              children: [
                                Text('Horas'),
                                Text(
                                  formattedDuration.hours + ':',
                                  style: TextStyle(
                                    color: colors.primary,
                                    fontSize: 80,
                                  ),
                                ),
                              ],
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Minutos'),
                              Text(
                                formattedDuration.minutes + ':',
                                style: TextStyle(
                                  color: colors.primary,
                                  fontSize: 80,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Segundos'),
                              Text(
                                formattedDuration.seconds,
                                style: TextStyle(
                                  color: colors.primary,
                                  fontSize: 80,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      CustomFilledButtom(
                        text: 'Solicitar ayuda',
                        onPressed: () {
                          final message =
                              'Solicito ayuda en mi viaje con Identificador: ${tripState.tripData?.viajeId}';
                          LaunchWspService().launchWhatsApp(
                              message: message, context: context);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Tu identificador de viaje es: N° ${tripState.tripData?.viajeId}')
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

class TripDuration {
  final String hours;
  final String minutes;
  final String seconds;

  TripDuration({
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}

TripDuration formatDuration(Duration duration) {
  final hours = duration.inHours.toString().padLeft(2, '0');
  final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
  final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

  return TripDuration(
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}
