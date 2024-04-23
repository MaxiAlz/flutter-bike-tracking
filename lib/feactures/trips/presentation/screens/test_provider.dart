import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/qr_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestProvider extends ConsumerWidget {
  const TestProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrStateValue = ref.watch(qrFormProvider);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Se escaneo el codigo papuli!'),
            Text('qrState: ${qrStateValue.qrValue}')
          ],
        ),
      ),
    );
  }
}
