import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TripDenied extends ConsumerWidget {
  const TripDenied({super.key});

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
              '¡Alto ahi! 🛑',
              style: titlesStyle.titleLarge,
            ),
          ),
        ),
        Center(
          child: Text(
            'Tu solicitud de viaje ah sido Denegada',
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
              'assets/svg/undraw_warning_re_eoyh_red.svg',
              width: 350.0,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text(
            'Regula tu situacion e intenta mas tarde',
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
            }),
      ],
    ));
  }
}
