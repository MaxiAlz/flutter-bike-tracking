import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ScanCodeButton extends StatelessWidget {
  const ScanCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    return CustomCenterFloatingActionButton(
      icon: Icons.qr_code_scanner_outlined,
      onPressed: () {},
    );
  }
}
