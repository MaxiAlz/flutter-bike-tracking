import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/register_form_provider.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/masks/input_masks.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalInformationForm extends ConsumerWidget {
  const PersonalInformationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);

    final smallTextStyle = Theme.of(context).textTheme.titleSmall;

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final dateOfBirthController = TextEditingController();

    setDateOfBirth() {
      String withoutMask =
          InputMaskFormated.getMask(maskType: MaskType.dateOfBirthMask)
              .getUnmaskedText();
      ref.read(registerFormProvider.notifier).onDateOfBirthChange(withoutMask);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Registrarse',
            style: titleStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          InfoText(
              subTitleStyle: smallTextStyle,
              text:
                  '¡Necesitaremos algunos de tus datos para crear tu cuenta!'),
          VBCustomTextInput(
            // controller: textController,
            // focusNode: focusNode,
            hintText: 'Nombre',
            labelText: 'Nombre',
            errorMessage: registerForm.name.errorMessage,
            onChanged: ref.read(registerFormProvider.notifier).onNameChange,
          ),
          VBCustomTextInput(
            // controller: textController,
            // focusNode: focusNode,
            hintText: 'Apellido',
            labelText: 'Apellido',
            errorMessage: registerForm.lastName.errorMessage,
            onChanged: ref.read(registerFormProvider.notifier).onLastNameChange,
          ),
          VBCustomTextInput(
            // focusNode: focusNode,
            hintText: 'Correo electronico',
            labelText: 'Correo electronico',
            keyboardType: TextInputType.emailAddress,
            errorMessage: registerForm.lastName.errorMessage,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            inputFormatters: [
              InputMaskFormated.getMask(maskType: MaskType.dateOfBirthMask)
            ],
            keyboardType: TextInputType.phone,
            onTapOutside: (event) {
              setDateOfBirth();
            },
            controller: dateOfBirthController,
            onEditingComplete: () {
              setDateOfBirth();
            },
            decoration: InputDecoration(
                hintText: 'DD / MM / AAAA',
                hintStyle: const TextStyle(fontSize: 18),
                labelText: 'Fecha de nacimiento',
                errorText: registerForm.identificationNumber.errorMessage,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ],
      ),
    );
  }
}
