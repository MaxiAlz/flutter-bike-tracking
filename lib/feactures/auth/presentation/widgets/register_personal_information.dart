import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
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

  bool isValidEmail(String value) {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(genderProvider);
    final smallTextStyle = Theme.of(context).textTheme.titleSmall;
    final colors = Theme.of(context).colorScheme;
    final maskFormated = InputMaskFormated();
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
                  ),
                  VBCustomTextInput(
                    controller: lastNameController,
                    hintText: 'Apellido',
                    labelText: 'Apellido',
                    validator: (value) {
                      if (value!.isEmpty) return "Campo requerido";
                      return null;
                    },
                  ),
                  VBCustomTextInput(
                    controller: phoneNumberController,
                    inputFormatters: [
                      maskFormated.getMask(maskType: MaskType.phoneNumberMask)
                      // InputMaskFormated.getMask(
                      //     maskType: MaskType.phoneNumberMask)
                    ],
                    hintText: '(383) 412-345',
                    labelText: 'Telefono celular',
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) return "Campo requerido";
                      return null;
                    },
                  ),
                  VBCustomTextInput(
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
                      if (!isValidEmail(value)) return "Formato invalido";
                      return null;
                    },
                    // onChanged:
                    //     ref.read(registerFormProvider.notifier).onEmailChange,
                  ),
                  VBCustomTextInput(
                    controller: dniController,
                    inputFormatters: [
                      maskFormated.getMask(maskType: MaskType.dniMask)
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
                      maskFormated.getMask(maskType: MaskType.dateOfBirthMask)
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
                        label: ' M',
                        icon: const Icon(Icons.male),
                        context: context,
                        ref: ref,
                        selectedGender: gender,
                        value: 'M'),
                    const SizedBox(width: 10), // Espaciado entre botones
                    _buildGenderButton(
                      label: ' F',
                      icon: const Icon(Icons.female),
                      value: 'F',
                      context: context,
                      ref: ref,
                      selectedGender: gender,
                    ),
                    const SizedBox(width: 10), // Espaciado entre botones
                    _buildGenderButton(
                      icon: const Icon(Icons.transgender),
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
                                identificationNumberUnmasked:
                                    maskFormated.getUnmaskedValue(
                                        maskedValue: dniController.text,
                                        maskType: MaskType.dniMask),
                                phoneNumberUnmasked:
                                    maskFormated.getUnmaskedValue(
                                        maskedValue: phoneNumberController.text,
                                        maskType: MaskType.phoneNumberMask),
                                name: nameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                dateOfBirth: dateOfBirthController.text,
                                identificationNumber: dniController.text,
                                phoneNumber: phoneNumberController.text,
                                gender: gender as String,
                              );
                          ref.read(goRouterProvider).push('/file-register');
                        }
                      }),
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
    required Icon icon,
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
    child: Row(
      children: [
        icon,
        Text(
          label,
          style: const TextStyle(
            // fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
