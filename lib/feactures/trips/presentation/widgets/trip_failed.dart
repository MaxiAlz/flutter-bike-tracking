// undraw_access_denied_re_awnf

import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TripRequestFailed extends ConsumerWidget {
  const TripRequestFailed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titlesStyle = Theme.of(context).textTheme;
    final tripProvider = ref.watch(tripNotifierProvider);

    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              'Oops! :(',
              style: titlesStyle.titleLarge,
            ),
          ),
        ),
        Center(
          child: Text(
            'Tu solicitud de viaje ah Fallado, pruebe mas tarde.',
            style: titlesStyle.titleMedium,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Center(
            child: SvgPicture.asset(
              'assets/svg/undraw_access_denied_re_awnf.svg',
              width: 350.0,
            ),
          ),
        ),
        const Center(
          child: Text(
            'Mesaje de error:',
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            tripProvider.errorMessage.toUpperCase(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomFilledButtom(
            text: 'Volver a home',
            onPressed: () async {
              await ref
                  .read(tripNotifierProvider.notifier)
                  .changeStatusToAnyState(tripstatus: TripStatus.notTravelling);
              ref.read(goRouterProvider).push('/');
            })
      ],
    ));
  }
}
