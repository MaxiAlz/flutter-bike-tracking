import 'dart:convert';

import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/locker_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterBikePatentScreen extends ConsumerWidget {
  const EnterBikePatentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final colors = Theme.of(context).colorScheme;
    final titlesStyles = Theme.of(context).textTheme;

    // final qrStateValue = ref.watch(qrFormProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/vamos-en-bici-01.png',
              width: 250,
            ),
            Text(
              'Ingresar identificacion',
              style: titlesStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            Text('Escribe la identificacion de la bicicleta',
                style: titlesStyles.titleMedium),
            Container(
              margin: const EdgeInsets.all(20),
              child: const _FomEnterLocker(),
            ),
            // const SizedBox(height: 15),
            CustomOutlineButtom(
                text: 'Cancelar',
                onPressed: () {
                  ref.read(goRouterProvider).push('/');
                  ref.read(isLoadingProvider.notifier).update((state) => false);
                })
            // Text('qrState: ${qrStateValue.qrValue}')
          ],
        ),
      ),
    );
  }
}

class _FomEnterLocker extends ConsumerWidget {
  const _FomEnterLocker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final TextEditingController textController;
    // final FocusNode focusNode;
    final formKey = GlobalKey<FormState>();
    final tripProvider = ref.read(tripNotifierProvider.notifier);
    final isLoading = ref.watch(isLoadingProvider);

    Future submitTripRequest(context) async {
      ref.read(isLoadingProvider.notifier).update((state) => true);
      try {
        final lockerId = ref.watch(qrFormProvider).lockerValue;
        final userid = ref.watch(authProvider).user?.userId;

        final resp = await tripProvider.sendTripRequest(
            lockId: lockerId, userId: userid as int);

        if (resp.statusCode == 201) {
          ref.read(goRouterProvider).push('/trip-in-progress');
          return;
        }

        if (resp.statusCode == 404) {
          final Map<String, dynamic> responseBody = jsonDecode(resp.body);
          final String errorMessage =
              responseBody['message'] ?? 'Recurso no encontrado (404)';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // final msg =
        // Manejo de otras excepciones
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.not_interested,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text('Ocurrió un error, vuelva a intentarlo'),
              ],
            ),
            backgroundColor: Color.fromARGB(255, 172, 45, 36),
          ),
        );
      } finally {
        ref.read(isLoadingProvider.notifier).update((state) => false);
      }
    }

    return Form(
        key: formKey,
        child: GestureDetector(
          child: Column(
            children: [
              TextFormField(
                onSaved: (newValue) {
                  ref.read(qrFormProvider.notifier).setLockerValue(newValue);
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Campo requerido';
                  if (value.length > 15) return 'Campo demasiado largo';
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'EL321 ',
                  prefixIcon: const Icon(Icons.numbers),
                  hintStyle: const TextStyle(fontSize: 18),
                  labelText: 'Identificador',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(height: 15),
              isLoading
                  ? const LinearProgressIndicator()
                  : CustomFilledButtom(
                      text: 'Iniciar viaje',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState?.save();
                          submitTripRequest(context);
                        }
                      },
                    ),
            ],
          ),
        ));
  }
}
