import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
// import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/register_form_provider.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/share_infraestructure.dart';
import 'package:app_ciudadano_vc/shared/widgets/inputs/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberIdentificationForm extends ConsumerWidget {
  const NumberIdentificationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final registerForm = ref.watch(registerFormProvider);
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    final textController = TextEditingController();
    final focusNode = FocusNode();

    // void setDateOfBirth(String value) {
    //   print('==>>>>>>>>>>>> $value');
    //   String withoutMask = InputMaskFormated.getMask(maskType: MaskType.dniMask)
    //       .getUnmaskedText();
    //   // ref
    //   //     .read(registerFormProvider.notifier)
    //   //     .onIdentificationNumberChange(withoutMask);
    // }

    // void setPhoneNumber() {
    //   String withoutMask =
    //       InputMaskFormated.getMask(maskType: MaskType.phoneNumberMask)
    //           .getUnmaskedText();

    //   // ref.read(registerFormProvider.notifier).onPhoneNumberChange(withoutMask);
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Necesitaras tu DNI',
            style: titleStyle,
          ),
          const SmallInfoText(
              text:
                  'Necesitaras tu DNI y telefono celular para realizar la validacion digital'),
          VBCustomTextInput(
            hintText: '12.345.678',
            controller: textController,
            focusNode: focusNode,
            labelText: 'DNI',
            keyboardType: TextInputType.number,
            inputFormatters: [
              InputMaskFormated.getMask(maskType: MaskType.dniMask)
            ],

            // onEditingComplete: () {
            //   setDateOfBirth(textController.text);
            // },
            // errorMessage: registerForm.identificationNumber.errorMessage,
          ),
          const SizedBox(
            height: 20,
          ),
          VBCustomTextInput(
              // onEditingComplete: setPhoneNumber,
              inputFormatters: [
                InputMaskFormated.getMask(maskType: MaskType.phoneNumberMask)
              ],
              keyboardType: TextInputType.phone,
              hintText: '(383) 412-345',
              labelText: 'Telefono celular'),
          const SizedBox(
            height: 20,
          ),
          _GenderDropdown(),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _GenderDropdown extends ConsumerWidget {
  // List<String> genders = ['Masculino', 'Femenino'];
  List<DropdownMenuItem> genders = [
    const DropdownMenuItem(
      enabled: true,
      value: 'Seleccione',
      child: Text('seleccione'),
    ),
    const DropdownMenuItem(
      value: 'Masculino',
      child: Text('Masculino'),
    ),
    const DropdownMenuItem(
      value: 'Femenino',
      child: Text('Femenino'),
    ),
    const DropdownMenuItem(
      value: 'No_Especificado',
      child: Text('No especificado'),
    ),
  ];

  _GenderDropdown();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final colors = Theme.of(context).colorScheme;
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Género', // Texto del label
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          onChanged: (value) {
            // ref.read(registerFormProvider.notifier).onGenderChange(value);
          },
          // value: ref.watch(registerFormProvider).gender.value,
          items: genders,
          isExpanded: true,
          hint: const Text('Seleccione un género'),
        ),
      ),
    );
  }
}
