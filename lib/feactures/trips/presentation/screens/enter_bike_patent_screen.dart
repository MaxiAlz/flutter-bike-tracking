import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/locker_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:app_ciudadano_vc/shared/widgets/inputs/custom_text_input.dart';
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

    
    Future submitTripRequest() async {
      ref.read(isLoadingProvider.notifier).update((state) => true);
      try {
        final lockerId = ref.watch(qrFormProvider).lockerValue;
        final userid = ref.watch(authProvider).user?.userId;

        final resp = await tripProvider.sendTripRequest(
            lockId: lockerId, userId: userid as int);

        if (resp.statusCode == 201) {
          ref.read(goRouterProvider).push('/trip-in-progress');
        }
        
      } catch (e) {}
      ref.read(isLoadingProvider.notifier).update((state) => false);
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
                // controller: textController,
                // onTapOutside: (e) {
                //   focusNode.unfocus();
                // },
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
              CustomFilledButtom(
                text: 'Iniciar viaje',
                onPressed: () {
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


//  return Form(
//       key: formKey,
//       child: GestureDetector(
//         child: Column(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: TextFormField(
//                 inputFormatters: [
//                   maskFormated.getMask(maskType: MaskType.verificationCode)
//                 ],
//                 onTapOutside: (e) {
//                   focusNode.unfocus();
//                 },
//                 controller: textController,
//                 focusNode: focusNode,
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value!.isEmpty) return 'Campo requerido';
//                   if (value.length < 7) return 'formato invalido';
//                   return null;
//                 },
//                 onSaved: (newValue) {
//                   ref.read(authFormProvider.notifier).setVerificationCode(
//                       newVerificationCode: newValue as String);

//                   ref.read(authFormProvider.notifier).setUnmaskedValues(
//                       verificationCodeUnmasked: InputMaskFormated()
//                           .getUnmaskedValue(
//                               maskedValue: newValue,
//                               maskType: MaskType.verificationCode));
//                 },
//                 decoration: InputDecoration(
//                   hintText: '_-_-_-_ ',
//                   prefixIcon: const Icon(Icons.numbers),
//                   hintStyle: const TextStyle(fontSize: 18),
//                   labelText: 'Ingrese su codigo',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             InfoText(
//                 subTitleStyle: subTitleStyle,
//                 text:
//                     '¿No recibiste ningun codigo? Vuelve a escribir tu numero'),
//             const SizedBox(height: 40),
//             isloading
//                 ? const LinearProgressIndicator()
//                 : CustomFilledButtom(
//                     text: 'Validar mi codigo',
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         formKey.currentState?.save();
//                         submitPhoneAndCode();
//                       }
//                     },
//                   ),
//           ],
//         ),
//       ),
//     );