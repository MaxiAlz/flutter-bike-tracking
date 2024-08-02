import 'package:animate_do/animate_do.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
// import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckAuthStatus extends ConsumerWidget {
  const CheckAuthStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flash(
            curve: Curves.linear,
            duration: Duration(milliseconds: 4000),
            infinite: true,
            child: Image.asset(
              'assets/images/vamos-en-bici-01.png',
              fit: BoxFit.cover, // Ajustar la imagen dentro del contenedor
            ),
          ),
          Flash(
              curve: Curves.linear,
              duration: Duration(milliseconds: 3000),
              infinite: true,
              child: InfoText(
                text: 'Cargando...',
                subTitleStyle: subTitleStyle,
              )),
        ],
      )),
    );
  }
}
