import 'package:app_ciudadano_vc/shared/infraestructure/services/permissions_handler/permissions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckPermissionsView extends ConsumerWidget {
  const CheckPermissionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final systemPermisionProvier = ref.watch(permissionsAppProvider);
    final titlesStyle = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
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
                'Debe activar sus permisos de ubicacion.',
                style: titlesStyle.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: SvgPicture.asset(
              'assets/svg/undraw_my_location_re_r52x.svg',
              width: 350.0,
            ),
          ),
        ),
        Text(
          'Localizacion:  ${systemPermisionProvier.isGpsEnabled ? 'Activada' : 'Desactivada'}',
        ),
        Text(
          'Permisos de localizacion:  ${systemPermisionProvier.isGpsPermissionGranted ? 'Habilitados' : 'Deshabilitados'}',
        ),
        const SizedBox(
          height: 10,
        ),
        !systemPermisionProvier.isGpsPermissionGranted
            ? FilledButton(
                onPressed: () {
                  ref.read(permissionsAppProvider.notifier).checkGpsStatus();
                },
                child: const Text('Activar permisos manualmente'))
            : const SizedBox(),
      ],
    );
  }
}

