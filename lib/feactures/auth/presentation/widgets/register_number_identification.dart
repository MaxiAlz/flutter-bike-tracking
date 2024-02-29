import 'package:app_ciudadano_vc/shared/widgets/inputs/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NumberIdentificationForm extends StatelessWidget {
  const NumberIdentificationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dniMaskFormatter = MaskTextInputFormatter(
        mask: '##.###.###',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.titleMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Necesitaras tu DNI',
            style: titleStyle,
          ),
          Text(
            'Ingresa tus datos para hacer la verificacion digital',
            style: subtitleStyle,
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // TextFormField(
          //   inputFormatters: [dniMaskFormatter],
          //   decoration: InputDecoration(
          //       border:
          //           OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          //       hintText: '12.345.678',
          //       labelText: 'DNI'),
          //   keyboardType: TextInputType.number,
          // ),
          VBCustomTextInput(
            hintText: '12.345.678',
            labelText: 'DNI',
            keyboardType: TextInputType.number,
            inputFormatters: [dniMaskFormatter],
          ),
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
class _GenderDropdown extends StatelessWidget {
  String? selectedGender = '';
  // List<String> genders = ['Masculino', 'Femenino'];
  List<DropdownMenuItem> genders = [
    const DropdownMenuItem(
      value: 'Masculino',
      child: Text('Masculino'),
    ),
    const DropdownMenuItem(
      value: 'Femenino',
      child: Text('Femenino'),
    ),
  ];

  _GenderDropdown({
    this.selectedGender,
  });

  @override
  Widget build(BuildContext context) {
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
          onChanged: (value) {},
          value: selectedGender,
          items: genders,
          isExpanded: true,
          hint: const Text('Selecciona un género'),
        ),
      ),
    );
  }
}
