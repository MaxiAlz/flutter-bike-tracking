import 'package:animate_do/animate_do.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 231, 237, 243),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/vamos-en-bici-01.png',
            ),
            const SizedBox(height: 20),
            FadeIn(
              duration: const Duration(milliseconds: 200),
              child: Image.asset(
                'assets/images/sustentable-01.png',
              ),
            ),
            const SizedBox(height: 20),
            CustomFilledButtom(
              text: 'Comenzar',
              onPressed: () => context.push('/auth'),
            )
          ],
        ),
      ),
    );
  }
}
