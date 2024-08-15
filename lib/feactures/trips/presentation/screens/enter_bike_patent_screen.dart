import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/locker_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/toast_alerts/toastification.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterBikePatentScreen extends ConsumerWidget {
  const EnterBikePatentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titlesStyles = Theme.of(context).textTheme;
    return Center(
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
          CustomOutlineButtom(
              text: 'Cancelar',
              onPressed: () {
                ref.read(isLoadingProvider.notifier).update((state) => false);
                ref.read(goRouterProvider).push('/');
              })
        ],
      ),
    );
  }
}

class _FomEnterLocker extends ConsumerWidget {
  const _FomEnterLocker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final tripProvider = ref.read(tripNotifierProvider.notifier);
    final isLoading = ref.watch(isLoadingProvider);
    final toastificationService = ToastificationService();

    Future submitTripRequest() async {
      ref.read(isLoadingProvider.notifier).update((state) => true);
      final trackerCodigo = ref.watch(qrFormProvider).trackerIdValue;
      final userid = ref.watch(authProvider).user?.userId;
      try {
        final resp = await tripProvider.sendTripRequest(
            trackerCodigo: trackerCodigo, userId: userid as int);

        if (resp?.statusCode == 201) {
          ref.read(isLoadingProvider.notifier).update((state) => false);
          tripProvider.changeStatusToAnyState(tripstatus: TripStatus.pending);
        }

        if (resp?.statusCode == 400) {
          ref.read(isLoadingProvider.notifier).update((state) => false);
          tripProvider.changeStatusToAnyState(tripstatus: TripStatus.failed);
        }

        ref.read(isLoadingProvider.notifier).update((state) => false);
      } catch (error) {
        Exception(error);
        toastificationService.showErrorToast(
            message: 'Error al solicitar viaje');
      }
    }

    return Form(
        key: formKey,
        child: GestureDetector(
          child: Column(
            children: [
              TextFormField(
                onSaved: (newValue) {
                  ref.read(qrFormProvider.notifier).setTrackerIdValue(newValue);
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState?.save();
                          submitTripRequest();
                        }
                      },
                    ),
            ],
          ),
        ));
  }
}
