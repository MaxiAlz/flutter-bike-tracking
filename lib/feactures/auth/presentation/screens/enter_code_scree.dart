import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/widgets/Info_text.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/share_infraestructure.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class EnterCodeScreen extends ConsumerWidget {
  const EnterCodeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authForm = ref.watch(authFormProvider);

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;
    final textController = TextEditingController();
    final focusNode = FocusNode();

    void submitPhoneAndCode() {
      print(
          '===>::{phoneNumberUnmasked.}::==> ${authForm.phoneNumberUnmasked}');
      print(
          '===>::{verificationCodeUnmasked.}::==> ${authForm.verificationCodeUnmasked}');
    }

    // TODO: Crear el service aqui para logearse

    ;

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
                submitPhoneAndCode: submitPhoneAndCode,
                focusNode: focusNode,
                textController: textController),
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
  final void Function() submitPhoneAndCode;

  _InputVerificationCode({
    required this.submitPhoneAndCode,
    required this.textController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context, ref) {
    final authProvider = ref.watch(authFormProvider);
    final maskFormated = InputMaskFormated();
    final subTitleStyle = Theme.of(context).textTheme.titleMedium;

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
                },
                decoration: InputDecoration(
                  hintText: '_ _  _ _ ',
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
            CustomFilledButtom(
              text: 'Validar mi codigo',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState?.save();
                  ref.read(authFormProvider.notifier).setUnmaskedValues(
                      phoneNumberUnmasked: maskFormated.getUnmaskedValue(
                          maskedValue: authProvider.phoneNumber,
                          maskType: MaskType.phoneNumberMask),
                      verificationCodeUnmasked: maskFormated.getUnmaskedValue(
                          maskedValue: authProvider.verificationCode,
                          maskType: MaskType.verificationCode));

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
