import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanCodeButton extends ConsumerWidget {
  const ScanCodeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final colors = Theme.of(context).colorScheme;
    return CustomCenterFloatingActionButton(
        widthButton: 70,
        sizeIcon: 35,
        icon: Icons.qr_code_scanner_outlined,
        onPressed: () {
          ref.read(goRouterProvider).push('/scan-qr-new-trip');
        });
  }
}


// libreria : https://pub.dev/packages/qr_code_scanner