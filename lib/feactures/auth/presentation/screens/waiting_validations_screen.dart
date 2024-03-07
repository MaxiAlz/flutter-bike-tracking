import 'package:animate_do/animate_do.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
import 'package:flutter/material.dart';

class WaitingValidation extends StatelessWidget {
  const WaitingValidation({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 412,
            height: 232,
            child: ElasticIn(
              duration: const Duration(milliseconds: 300),
              child: Image.asset(
                'assets/images/vamos-en-bici-01.png',
              ),
            ),
          ),
          Column(
            children: [
              Text(
                '¡Estamos validado tus datos!',
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              InfoText(
                  subTitleStyle: subTitleStyle,
                  text: 'Serás notificado terminemos con este proceso'),
              const SizedBox(height: 20),
            ],
          ),
          const CircularProgressIndicator(),
          SizedBox(
            width: 412,
            height: 232,
            child: FadeIn(
              duration: const Duration(milliseconds: 100),
              child: Image.asset(
                'assets/images/capital-sustentable.png',
              ),
            ),
          ),
        ],
      )),
    );
  }
}
