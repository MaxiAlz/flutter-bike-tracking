import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripEnded extends ConsumerWidget {
  const TripEnded({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titlesStyles = Theme.of(context).textTheme;
    // final tripProvider = ref.watch(tripNotifierProvider).tripData;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              child: Image.asset(
            'assets/images/vamos-en-bici-01.png',
          )),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('¡Tu viaje ha finalizado! ',
                style: titlesStyles.titleLarge, textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Esperamos que hayas disfrutado tu paseo por la ciudad, te esperamos pronto',
              style: titlesStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomFilledButtom(
              text: 'Volver a home',
              onPressed: () {
                ref.read(goRouterProvider).push('/');
              })
        ],
      ),
    );
  }
}
