import 'package:animate_do/animate_do.dart';
import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/widgets/info_text.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElasticIn(
            duration: const Duration(milliseconds: 500),
            child: Image.asset(
              'assets/images/vamos-en-bici-01.png',
              width: 412,
            ),
          ),
          const SizedBox(height: 20),
          FadeIn(
            duration: const Duration(milliseconds: 100),
            child: Image.asset(
              'assets/images/capital-sustentable.png',
            ),
          ),
          const SizedBox(height: 20),
          CustomFilledButtom(
              text: 'Comenzar',
              onPressed: () => ref.read(goRouterProvider).push('/auth')),
          const SizedBox(height: 20),
          InfoText(
              subTitleStyle: titleTheme.bodySmall,
              text:
                  'Desarrollado por el departamento de modernizacion de SFV Catamarca'),
          TextButton(
            onPressed: () {},
            child: InfoText(
                subTitleStyle: titleTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline),
                text: 'Mas informacion aqui'),
          )
        ],
      ),
    );
  }
}
