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
            'Tu solicitud de viaje ah Fallado, prueba mas tarde',
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
