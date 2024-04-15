import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/widgets/Info_text.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/share_infraestructure.dart';
import 'package:app_ciudadano_vc/shared/providers/loading_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:app_ciudadano_vc/shared/widgets/notifications/show_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterCodeScreen extends ConsumerWidget {
  const EnterCodeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authForm = ref.watch(authFormProvider);

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;
    final codeTextController = TextEditingController();
    final focusNode = FocusNode();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 237, 243),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/vamos-en-bici-01.png',
              width: 250,
            ),
            Text(
              '¿Cual es tu codigo ?',
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            InfoText(
                subTitleStyle: subTitleStyle,
                text: 'Escribe el codigo que recibiste por SMS a:'),
            const SizedBox(height: 10),
            Text(
              authForm.phoneNumber,
              style: subTitleStyle?.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _InputVerificationCode(
                // submitPhoneAndCode: submitPhoneAndCode,
                focusNode: focusNode,
                textController: codeTextController),
          ],
        ),
      ),
    );
  }
}

class _InputVerificationCode extends ConsumerWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  final formKey = GlobalKey<FormState>();

  _InputVerificationCode({
    required this.textController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context, ref) {
    // final authProvider = ref.watch(authFormProvider);
    final maskFormated = InputMaskFormated();
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;
    final isloading = ref.watch(isLoadingProvider);

    Future submitPhoneAndCode() async {
      ref.read(isLoadingProvider.notifier).update((state) => true);

      final phoneNumber = ref.watch(authFormProvider).phoneNumberUnmasked;
      final code = ref.watch(authFormProvider).verificationCode;

      final codeUnmasked = maskFormated.getUnmaskedValue(
          maskedValue: code, maskType: MaskType.phoneNumberMask);

      try {
        final serviceResponse = await ref
            .read(authProvider.notifier)
            .loginUser(
                phoneNumber: phoneNumber, code: codeUnmasked);

        if (serviceResponse.statusCode == 400) {
          // ignore: use_build_context_synchronously
          ShowCustomSnackbar().show(
              context: context,
              label: 'Credenciales Invalidas',
              color: Colors.red);
          return;
        }
        if (serviceResponse.statusCode == 201) {
          ref.read(goRouterProvider).go('/home');
          // ignore: use_build_context_synchronously
          ShowCustomSnackbar().show(
              context: context, label: 'Hola pa', color: Colors.lightBlue);
          return serviceResponse;
        }

        return serviceResponse;
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        ShowCustomSnackbar().show(
            context: context, label: 'Ah ocurrido un error', color: Colors.red);

        return e.response;
      } finally {
        ref.read(isLoadingProvider.notifier).update((state) => false);
      }
    }

    return Form(
      key: formKey,
      child: GestureDetector(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                inputFormatters: [
                  maskFormated.getMask(maskType: MaskType.verificationCode)
                ],
                onTapOutside: (e) {
                  focusNode.unfocus();
                },
                controller: textController,
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Campo requerido';
                  if (value.length < 7) return 'formato invalido';
                  return null;
                },
                onSaved: (newValue) {
                  ref.read(authFormProvider.notifier).setVerificationCode(
                      newVerificationCode: newValue as String);

                  ref.read(authFormProvider.notifier).setUnmaskedValues(
                      verificationCodeUnmasked: InputMaskFormated()
                          .getUnmaskedValue(
                              maskedValue: newValue,
                              maskType: MaskType.verificationCode));
                },
                decoration: InputDecoration(
                  hintText: '_-_-_-_ ',
                  prefixIcon: const Icon(Icons.numbers),
                  hintStyle: const TextStyle(fontSize: 18),
                  labelText: 'Ingrese su codigo',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            const SizedBox(height: 40),
            InfoText(
                subTitleStyle: subTitleStyle,
                text:
                    '¿No recibiste ningun codigo? Vuelve a escribir tu numero'),
            const SizedBox(height: 40),
            isloading
                ? const LinearProgressIndicator()
                : CustomFilledButtom(
                    text: 'Validar mi codigo',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        submitPhoneAndCode();
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
