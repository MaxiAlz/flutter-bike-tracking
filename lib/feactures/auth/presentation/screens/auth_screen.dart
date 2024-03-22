import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/widgets/info_text.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/masks/input_masks.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;
    final temrsStyle = Theme.of(context).textTheme.titleSmall;

    final textController = TextEditingController();
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
              'Iniciar sesion',
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            InfoText(
                subTitleStyle: subTitleStyle,
                text:
                    'Te enviaremos un código por SMS para verificar tu número'),
            const SizedBox(height: 10),
            _InputPhoneNumber(
              textController: textController,
              focusNode: focusNode, /*  maskFormatter: maskFormatter */
            ),
            const SizedBox(height: 40),
            InfoText(
                subTitleStyle: temrsStyle,
                text:
                    'Al continuar estas de acuerdo con los terminos y condiciones vamos en bici'),
            const SizedBox(height: 40),
            _SendPhoneNumberButton(focusNode: focusNode),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿ No tienes cuenta ?'),
                TextButton(
                  onPressed: () {
                    ref.read(goRouterProvider).push('/register');
                  },
                  child: Text(
                    'Registrarse',
                    style: subTitleStyle!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SendPhoneNumberButton extends ConsumerWidget {
  const _SendPhoneNumberButton({
    required this.focusNode,
  });

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, ref) {
    return CustomFilledButtom(
      text: /* 'Solicitar codigo' */ 'Siguiente',
      onPressed: () {
        // ref.read(authFormProvider.notifier).onSubmitPhoneNumber(context);
        // focusNode.unfocus();
        ref.read(goRouterProvider).push('/enter-code');
        // context.push('/enter-code');
      },
    );
  }
}

class _InputPhoneNumber extends ConsumerWidget {
  final TextEditingController textController;
  final FocusNode focusNode;

  const _InputPhoneNumber({
    required this.textController,
    required this.focusNode,
  });

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, ref) {
    final authForm = ref.watch(authFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;

      showSnackbar(context, next.errorMessage);
    });
    // final ref = ProviderRef.of(context, listen: false);

    textController.addListener(() {
      // Si el usuario borra todo el texto, vacía el campo de entrada.
      if (textController.text.isEmpty) {
        textController.clear();
      }
    });

    return GestureDetector(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          inputFormatters: [
            InputMaskFormated.getMask(maskType: MaskType.phoneNumberMask)
          ],
          onTapOutside: (e) {
            focusNode.unfocus();
          },
          controller: textController,
          focusNode: focusNode,
          keyboardType: TextInputType.phone,
          onChanged: ref.read(authFormProvider.notifier).onPhoneNumberChange,
          onFieldSubmitted: (value) {},
          decoration: InputDecoration(
            errorText: authForm.isPhoneNumberSubmitted
                ? authForm.phoneNumber.errorMessage
                : null,
            hintText: '(383) 412-3456',
            prefixIcon: const Icon(Icons.phone),
            hintStyle: const TextStyle(fontSize: 18),
            labelText: 'Ingrese su numero',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
