import 'package:animate_do/animate_do.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/widgets/info_text.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 231, 237, 243),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            CustomFilledButtom(
              text: 'Comenzar',
              onPressed: () => context.push('/auth'),
            ),
            const SizedBox(height: 20),
            InfoText(
                subTitleStyle: subTitleStyle,
                text:
                    'Desarrollado por el departamento de modernizacion de SFV Catamarca'),
            Positioned(
              bottom: 100,
              height: 10000000,
              left: 0,
              child: TextButton(
                  onPressed: () {},
                  child: InfoText(
                      subTitleStyle: subTitleStyle?.copyWith(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                      text: 'Mas informacion aqui')),
            )
          ],
        ),
      ),
    );
  }
}
