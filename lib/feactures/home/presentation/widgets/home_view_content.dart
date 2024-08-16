import 'package:app_ciudadano_vc/feactures/home/presentation/home_presentation.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/map_presentation.dart';
import 'package:app_ciudadano_vc/shared/widgets/gradiente/custom_gradient.dart';

import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const MapViewLayer(),
      const CustomGradient(
        bottom: 0,
        top: 700,
        left: 0,
        right: 0,
        width: 10,
        height: 10,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      Container(
        alignment: Alignment.bottomLeft,
        child: Image.asset(
          'assets/images/vamos-en-bici-01.png',
          width: 150,
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
          child: ScanCodeButton(),
        ),
      ),
    ]);
  }
}
