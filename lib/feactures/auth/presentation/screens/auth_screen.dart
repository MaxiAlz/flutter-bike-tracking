import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/widgets/info_text.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;

    final textController = TextEditingController(text: '+54');
    // textController.selection =
    //     const TextSelection.collapsed(offset: '+54'.length);
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
              '¿Cual es tu numero ?',
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            InfoText(
                subTitleStyle: subTitleStyle,
                text:
                    'Te enviaremos un código por SMS para verificar tu número'),
            const SizedBox(height: 20),

            _InputPhoneNumber(
              textController: textController,
              focusNode: focusNode, /*  maskFormatter: maskFormatter */
            ),

            // const CustomTextFormField(obscureText: false,keyboardType: ),
            const SizedBox(height: 40),
            InfoText(
                subTitleStyle: subTitleStyle,
                text:
                    'Al continuar estas de acuerdo con los terminos y condiciones vamos en bici'),
            const SizedBox(height: 40),
            _SendPhoneNumberButton(
                /* maskFormatter: maskFormatter, */ focusNode: focusNode),
          ],
        ),
      ),
    );
  }
}

class _SendPhoneNumberButton extends ConsumerWidget {
  const _SendPhoneNumberButton({
    /*  required this.maskFormatter, */
    required this.focusNode,
  });

  /* final MaskTextInputFormatter maskFormatter; */
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, ref) {
    return CustomFilledButtom(
      text: 'Solicitar codigo',
      onPressed: () {
        ref.read(authFormProvider.notifier).onSubmitPhoneNumber();
        focusNode.unfocus();
      },
    );
  }
}

class _InputPhoneNumber extends ConsumerWidget {
  final maskFormatter = MaskTextInputFormatter(
      mask: '+## (###) #-##-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final TextEditingController textController;
  final FocusNode focusNode;

  _InputPhoneNumber({
    required this.textController,
    required this.focusNode,
  }) {
    textController.selection = const TextSelection.collapsed(offset: 3);
  }

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          inputFormatters: [maskFormatter],
          onTapOutside: (e) {
            focusNode.unfocus();
          },
          controller: textController,
          focusNode: focusNode,
          keyboardType: TextInputType.phone,
          onChanged: ref.read(authFormProvider.notifier).onPhoneNumberChange,
          onFieldSubmitted: (value) {
            textController.clear();
          },
          decoration: InputDecoration(
              hintText: '+54 (383) 4-12-34-56',
              prefixIcon: const Icon(Icons.phone),
              hintStyle: const TextStyle(fontSize: 18),
              labelText: 'Ingrese su numero',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
  }
}
