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

            // _SendPhoneNumberButton(focusNode: focusNode),
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

class _InputPhoneNumber extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();

  final TextEditingController textController;
  final FocusNode focusNode;

  _InputPhoneNumber({
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
    // final authForm = ref.watch(authFormProvider);
    final maskFormated = InputMaskFormated();
    final temrsStyle = Theme.of(context).textTheme.titleSmall;

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

    return Form(
      key: formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            TextFormField(
              inputFormatters: [
                maskFormated.getMask(maskType: MaskType.phoneNumberMask)
              ],
              onTapOutside: (e) {
                focusNode.unfocus();
              },
              onSaved: (newValue) {
                ref
                    .read(authFormProvider.notifier)
                    .setPhoneNumber(newPhoneNumber: newValue as String);
              },
              validator: (value) {
                if (value!.isEmpty) return "Campo requerido";
                if (value.length < 14) return "Fomato invalido";
                return null;
              },
              controller: textController,
              focusNode: focusNode,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '(383) 412-3456',
                prefixIcon: const Icon(Icons.phone),
                hintStyle: const TextStyle(fontSize: 18),
                labelText: 'Ingrese su numero',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 40),
            InfoText(
                subTitleStyle: temrsStyle,
                text:
                    'Al continuar estas de acuerdo con los terminos y condiciones vamos en bici'),
            const SizedBox(height: 40),
            CustomFilledButtom(
              text: 'Siguiente',
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState?.save();
                  ref.read(goRouterProvider).push('/enter-code');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
