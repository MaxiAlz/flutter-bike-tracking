import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/enter_code_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/widgets/Info_text.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EnterCodeScreen extends ConsumerWidget {
  const EnterCodeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authForm = ref.watch(authFormProvider);

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;
    final textController = TextEditingController();
    final focusNode = FocusNode();
    final maskFormatter = MaskTextInputFormatter(
        mask: '##-##-##-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

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
              authForm.phoneNumber.value,
              style: subTitleStyle?.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _InputVerificationCode(
                maskFormatter: maskFormatter,
                focusNode: focusNode,
                textController: textController),
            const SizedBox(height: 40),
            InfoText(
                subTitleStyle: subTitleStyle,
                text:
                    '¿No recibiste ningun codigo? Vuelve a escribir tu numero'),
            const SizedBox(height: 40),
            CustomFilledButtom(
              text: 'Validar mi codigo',
              onPressed:
                  ref.read(enterCodePRovider.notifier).onSubmitValidateCode,
            ),
            // FilledButton(
            //     onPressed:
            //         ref.read(enterCodePRovider.notifier).onSubmitValidateCode,
            //     child: Text('maver'))
          ],
        ),
      ),
    );
  }
}

class _InputVerificationCode extends ConsumerWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  final MaskTextInputFormatter? maskFormatter;

  const _InputVerificationCode({
    required this.textController,
    required this.focusNode,
    this.maskFormatter,
  });

  @override
  Widget build(BuildContext context, ref) {
    // final authForm = ref.watch(authFormProvider);

    final enterCodeForm = ref.watch(enterCodePRovider);

    return GestureDetector(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          inputFormatters: [maskFormatter!],
          onTapOutside: (e) {
            focusNode.unfocus();
          },
          controller: textController,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          onChanged: /*  (value) {}, */
              // ref.read(authFormProvider.notifier).onVerificationCodeChange,
              ref.read(enterCodePRovider.notifier).onChangeValidateCode,
          onFieldSubmitted: (value) {
            textController.clear();
          },
          decoration: InputDecoration(
            errorText: enterCodeForm.isCodeSubmitted
                ? enterCodeForm.validateCode.errorMessage
                : null,
            hintText: '_ _ - _ _ -  _ _',
            prefixIcon: const Icon(Icons.numbers),
            hintStyle: const TextStyle(fontSize: 18),
            labelText: 'Ingrese su codigo',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    );
  }
}
