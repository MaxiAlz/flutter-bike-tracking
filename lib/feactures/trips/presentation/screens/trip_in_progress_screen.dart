import 'dart:async';

import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_center_floating_action.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_circular_button.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TripInProgressScreen extends StatelessWidget {
  const TripInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final subtitlesStyle = Theme.of(context).textTheme.titleMedium;
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
  Duration tripDuration = Duration();
  Timer? timer;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (!isPaused) {
        setState(() {
          tripDuration += Duration(seconds: 1);
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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child:
                // SizedBox(height: , ),
                Container(
              child: Image.asset(
                'assets/images/Vamos-en-Bici-11_2.jpeg',

                fit: BoxFit.cover,
                // width: double.maxFinite,
              ),
            ),
          ),
          _counterViewer(colors),
        ],
      ),
    );
  }

  Positioned _counterViewer(ColorScheme colors) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(20.0),
          //   topRight: Radius.circular(20.0),
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 8.0,
              spreadRadius: 2.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
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
            // SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomCircularButton(
                      iconColor: Colors.white,
                      icon: isPaused ? Icons.play_arrow : Icons.pause,
                      label: isPaused ? 'Reanudar' : 'Pausar',
                      labelColor: colors.primary,
                      backgroundColor: colors.primary,
                      onPressed: togglePause),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomCircularButton(
                      iconColor: Colors.white,
                      icon: Icons.stop,
                      labelColor: colors.primary,
                      label: 'Finalizar',
                      backgroundColor: Colors.red,
                      onPressed: endTrip),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
