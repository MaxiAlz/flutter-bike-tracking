import 'package:app_ciudadano_vc/feactures/auth/presentation/widgets/Info_text.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EnterCodeScreen extends StatelessWidget {
  const EnterCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;

    final textController = TextEditingController();

    final focusNode = FocusNode();
    final maskFormatter = MaskTextInputFormatter(
        mask: '##-##-##-##',
        // filter: {"#": RegExp(r'[0-9]')},
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
                text: 'Escribe el codigo que recibiste por SMS'),
            const SizedBox(height: 20),
            _InputPhoneNumber(
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
              text: 'Registrarme',
              onPressed: () {
                print(
                    ' maskFormatter #######33 ${maskFormatter.getUnmaskedText()}');
                focusNode.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InputPhoneNumber extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode focusNode;

  final MaskTextInputFormatter? maskFormatter;

  const _InputPhoneNumber(
      {required this.textController,
      required this.focusNode,
      this.maskFormatter});

  @override
  Widget build(BuildContext context) {
    // final textController = TextEditingController();

    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
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
          onFieldSubmitted: (value) {
            textController.clear();
          },
          decoration: InputDecoration(
              hintText: '_ _ _ _ _ _',
              prefixIcon: const Icon(Icons.numbers),
              hintStyle: const TextStyle(fontSize: 18),
              labelText: 'Ingrese su codigo',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
  }
}
