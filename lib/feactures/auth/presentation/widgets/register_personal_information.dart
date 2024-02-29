import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonalInformationForm extends StatelessWidget {
  // final TextEditingController textController;
  // final FocusNode focusNode;
  const PersonalInformationForm({
    super.key,
    // required this.focusNode,
    // required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final birthDaymaskFormatter = MaskTextInputFormatter(
        mask: '## / ## / ####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Ingresa tus datos',
            style: titleStyle,
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // TextFormField(
          //   decoration: InputDecoration(
          //       border:
          //           OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          //       hintText: 'Nombre',
          //       labelText: 'Nombre'),
          // ),
          const VBCustomTextInput(
            hintText: 'Nombre',
            labelText: 'Nombre',
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // TextFormField(
          //   decoration: InputDecoration(
          //       border:
          //           OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          //       hintText: 'Apellido',
          //       labelText: 'Apellido'),
          // ),
          const VBCustomTextInput(hintText: 'Apellido', labelText: 'Apellido'),
          // const SizedBox(
          //   height: 20,
          // ),
          // TextFormField(
          //   decoration: InputDecoration(
          //       border:
          //           OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          //       hintText: 'Correo electronico',
          //       labelText: 'Correo electronico'),
          // ),
          const VBCustomTextInput(
            hintText: 'Correo electronico',
            labelText: 'Correo electronico',
            keyboardType: TextInputType.emailAddress,
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // TextFormField(
          //   keyboardType: TextInputType.datetime,
          //   inputFormatters: [birthDaymaskFormatter],
          //   decoration: InputDecoration(
          //     border:
          //         OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          //     hintText: 'Fecha de nacimiento',
          //     labelText: 'Fecha de nacimiento',
          //   ),
          // ),
          VBCustomTextInput(
            hintText: '01 / 10 / 1998',
            labelText: 'Fecha de nacimiento',
            keyboardType: TextInputType.datetime,
            inputFormatters: [birthDaymaskFormatter],
          )
        ],
      ),
    );
  }
}
