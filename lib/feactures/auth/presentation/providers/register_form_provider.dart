import 'package:app_ciudadano_vc/shared/infraestructure/inputs/inputs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormNofier, RegisterFormState>((ref) {
  return RegisterFormNofier();
});

class RegisterFormState {
  final NameInput name;
  final LastnameInput lastName;
  final EmailInput email;
  final DateOfBirth dateOfBirth;
  final IdentificationNumber identificationNumber;
  final GenderInput gender;
  final FileInput profileImage;
  final FileInput dniFrontImage;
  final FileInput dniBackImage;

  final String? errorMessage;
  final bool isLoading;
  final bool isFormSubmitted;

  RegisterFormState({
    this.name = const NameInput.pure(),
    this.lastName = const LastnameInput.pure(),
    this.email = const EmailInput.pure(),
    this.dateOfBirth = const DateOfBirth.pure(),
    this.identificationNumber = const IdentificationNumber.pure(),
    this.gender = const GenderInput.pure(),
    this.profileImage = const FileInput.pure(),
    this.dniFrontImage = const FileInput.pure(),
    this.dniBackImage = const FileInput.pure(),
    this.errorMessage,
    this.isLoading = false,
    this.isFormSubmitted = false,
  });

  RegisterFormState copyWith({
    NameInput? name,
    LastnameInput? lastName,
    EmailInput? email,
    DateOfBirth? dateOfBirth,
    IdentificationNumber? identificationNumber,
    GenderInput? gender,
    FileInput? profileImage,
    FileInput? dniFrontImage,
    FileInput? dniBackImage,
    String? errorMessage,
    bool? isLoading,
    bool? isFormSubmitted,
  }) {
    return RegisterFormState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      gender: gender ?? this.gender,
      profileImage: profileImage ?? this.profileImage,
      dniFrontImage: dniFrontImage ?? this.dniFrontImage,
      dniBackImage: dniBackImage ?? this.dniBackImage,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isFormSubmitted: isFormSubmitted ?? this.isFormSubmitted,
    );
  }

  @override
  String toString() {
    return ''' 
        LoginFormState:
        name: $name
        lastName: $lastName
        email: $email
        dateOfBirth: $dateOfBirth
        identificationNumber: $identificationNumber
        gender: $gender
        ''';
  }
}

class RegisterFormNofier extends StateNotifier<RegisterFormState> {
  RegisterFormNofier() : super(RegisterFormState());

  onNameChange(String value) {
    print('====onNameChange====>>>>>>>>>>>> ${state.name}');
    state = state.copyWith(name: NameInput.dirty(value));
  }

  void onLastNameChange(String value) {
    print('====onLastNameChange====>>>>>>>>>>>> ${state.lastName.value}');
    state = state.copyWith(lastName: LastnameInput.dirty(value));
  }

  void onEmailChange(String value) {
    state = state.copyWith(email: EmailInput.dirty(value));
  }

  void asd(value) {
    print('asdasd==>>>> $value');
    print(state.toString());
    final withoutMask = value.replaceAll(RegExp(r'[^0-9]'), '');

    state = state.copyWith(dateOfBirth: DateOfBirth.dirty(withoutMask));
  }

  void onDateOfBirthChange(String value) {
    state = state.copyWith(dateOfBirth: DateOfBirth.dirty(value));
    print(state.toString());
  }

  void onIdentificationNumberChange(String value) {
    state =
        state.copyWith(identificationNumber: IdentificationNumber.dirty(value));
  }

  void onGenderChange(String value) {
    print('====onGenderChange====>>>>>>>>>>>> ${state.gender.value}');
    state = state.copyWith(gender: GenderInput.dirty(value));
  }

  onSubmittRegisterForm() {
    // -_validateForm();

    print(state.toString());
  }

  _validateForm() {
    if (state.name.value.isEmpty) {
      state = state.copyWith(errorMessage: 'El nombre es obligatorio');
      return;
    }

    // Otras validaciones para los demás campos del formulario...

    // Si todas las validaciones pasan, establece el estado de éxito
    state = state.copyWith(errorMessage: null, isFormSubmitted: true);
  }
}
