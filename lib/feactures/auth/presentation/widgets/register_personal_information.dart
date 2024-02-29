import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/register_form_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonalInformationForm extends ConsumerWidget {
  const PersonalInformationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);

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
          const SizedBox(
            height: 20,
          ),
          VBCustomTextInput(
            hintText: 'Nombre',
            labelText: 'Nombre',
            errorMessage: registerForm.name.errorMessage,
            onChanged: ref.read(registerFormProvider.notifier).onNameChange,
          ),
          const VBCustomTextInput(hintText: 'Apellido', labelText: 'Apellido'),
          const VBCustomTextInput(
            hintText: 'Correo electronico',
            labelText: 'Correo electronico',
            keyboardType: TextInputType.emailAddress,
          ),
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
