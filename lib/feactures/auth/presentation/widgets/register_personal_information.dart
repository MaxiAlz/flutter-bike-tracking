import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
// import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/register_form_provider.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/masks/input_masks.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genderProvider = StateProvider<String?>((ref) => 'X');

class PersonalInformationForm extends ConsumerWidget {
  // ** CONTROLADORES **
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController pgenderController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  PersonalInformationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // bool buttonPressed = false;
    final gender = ref.watch(genderProvider);
    // final registerForm = ref.watch(registerFormProvider);

    final smallTextStyle = Theme.of(context).textTheme.titleSmall;
    final colors = Theme.of(context).colorScheme;

    final titleStyle = Theme.of(context).textTheme.titleLarge;

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
          Form(
              key: formKey,
              child: Column(
                children: [
                  VBCustomTextInput(
                    controller: nameController,
                    hintText: 'Nombre',
                    labelText: 'Nombre',
                    // errorMessage: registerForm.name.errorMessage,
                    onSaved: (value) {
                      // ref.read(registerFormProvider.notifier).onNameChange;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return "Campo requerido";
                      return null;
                    },
                    // onChanged:
                    //     ref.read(registerFormProvider.notifier).onNameChange,
                  ),
                  VBCustomTextInput(
                    controller: lastNameController,
                    hintText: 'Apellido',
                    labelText: 'Apellido',
                    // errorMessage: registerForm.lastName.errorMessage,
                    onSaved: (value) {
                      // ref.read(registerFormProvider.notifier).onLastNameChange;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return "Campo requerido";
                      return null;
                    },
                  ),
                  VBCustomTextInput(
                    controller: phoneNumberController,
                    hintText: '(383) 412-345',
                    labelText: 'Telefono celular',
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      // ref
                      //     .read(registerFormProvider.notifier)
                      //     .onPhoneNumberChange;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return "Campo requerido";
                      return null;
                    },
                  ),
                  VBCustomTextInput(
                    // focusNode: focusNode,
                    controller: emailController,
                    hintText: 'Correo electronico',
                    labelText: 'Correo electronico',
                    keyboardType: TextInputType.emailAddress,
                    // errorMessage: registerForm.lastName.errorMessage,
                    onSaved: (value) {
                      // ref.read(registerFormProvider.notifier).onEmailChange;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return "Campo requerido";
                      return null;
                    },
                    // onChanged:
                    //     ref.read(registerFormProvider.notifier).onEmailChange,
                  ),
                  VBCustomTextInput(
                    controller: dniController,
                    inputFormatters: [
                      InputMaskFormated.getMask(maskType: MaskType.dniMask)
                    ],
                    hintText: '12.345.678',
                    labelText: 'DNI',
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      // ref
                      //     .read(registerFormProvider.notifier)
                      //     .onIdentificationNumberChange;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return "Campo requerido";
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: dateOfBirthController,
                    inputFormatters: [
                      InputMaskFormated.getMask(
                          maskType: MaskType.dateOfBirthMask)
                    ],
                    onSaved: (newValue) {
                      // ref
                      //     .read(registerFormProvider.notifier)
                      //     .onDateOfBirthChange;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return "Campo requerido";
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'DD/MM/AAAA',
                        hintStyle: const TextStyle(fontSize: 18),
                        labelText: 'Fecha de nacimiento',
                        // errorText: registerForm.dateOfBirth.errorMessage,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Text(
                      'Genero con el que identifique:',
                      style: TextStyle(color: colors.primary),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    // 'Masculino', 'M', gender, ref, context
                    _buildGenderButton(
                        label: ' Masculino',
                        context: context,
                        ref: ref,
                        selectedGender: gender,
                        value: 'M'),
                    const SizedBox(width: 10), // Espaciado entre botones
                    _buildGenderButton(
                      label: ' Femenino',
                      value: 'F',
                      context: context,
                      ref: ref,
                      selectedGender: gender,
                    ),
                    const SizedBox(width: 10), // Espaciado entre botones
                    _buildGenderButton(
                      label: 'Otro',
                      value: 'X',
                      context: context,
                      ref: ref,
                      selectedGender: gender,
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFilledButtom(
                      text: 'Siguiente',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState?.save();
                          ref
                              .read(registerFormProvider.notifier)
                              .setUserDataState(
                                name: nameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                dateOfBirth: dateOfBirthController.text,
                                identificationNumber: dniController.text,
                                phoneNumber: phoneNumberController.text,
                                gender: gender as String,
                              );
                        }
                      }),
                  OutlinedButton(
                      onPressed: () {
                        ref.read(registerFormProvider.notifier).printState();
                      },
                      child: Text('printState')),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

Widget _buildGenderButton(
    {required String label,
    required String value,
    required String? selectedGender,
    required WidgetRef ref,
    required BuildContext context}) {
  final colors = Theme.of(context).colorScheme;
  return FilledButton(
    onPressed: () {
      ref.read(genderProvider.notifier).update((state) => value);
    },
    style: FilledButton.styleFrom(
      backgroundColor: selectedGender == value
          ? colors.primary
          : Colors.grey, // Color del botón seleccionado
      foregroundColor: Colors.white, // Color del texto del botón
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Borde redondeado del botón
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        // fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
