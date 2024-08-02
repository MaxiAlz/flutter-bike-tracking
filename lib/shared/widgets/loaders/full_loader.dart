import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class FullLoader extends StatelessWidget {
  final String? label;
  const FullLoader({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flash(
          curve: Curves.linear,
          duration: const Duration(milliseconds: 4000),
          infinite: true,
          child: Image.asset(
            'assets/images/vamos-en-bici-01.png',
            fit: BoxFit.cover, // Ajustar la imagen dentro del contenedor
          ),
        ),
        Flash(
            curve: Curves.linear,
            duration: const Duration(milliseconds: 2000),
            infinite: true,
            child: InfoText(
              text: label ?? 'Cargando...',
              subTitleStyle: subTitleStyle,
            )),
      ],
    );
  }
}
