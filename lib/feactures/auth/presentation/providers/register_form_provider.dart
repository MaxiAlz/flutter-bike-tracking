import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
  // final registerUserCallback = ref.watch(registe)
  return RegisterFormNotifier();
});

// Estado del formulario

class RegisterFormState {
  final String name;
  final String lastName;
  final String email;
  final String dateOfBirth;
  final String identificationNumber;
  final String identificationNumberUnmasked;
  final String phoneNumber;
  final String phoneNumberUnmasked;
  final String gender;

  RegisterFormState({
    this.identificationNumberUnmasked = '',
    this.phoneNumberUnmasked = '',
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.dateOfBirth = '',
    this.identificationNumber = '',
    this.gender = '',
    this.phoneNumber = '',
  });

  RegisterFormState copyWith({
    String? name,
    String? lastName,
    String? email,
    String? dateOfBirth,
    String? identificationNumber,
    String? identificationNumberUnmasked,
    String? phoneNumber,
    String? phoneNumberUnmasked,
    String? gender,
  }) {
    return RegisterFormState(
      identificationNumberUnmasked:
          identificationNumberUnmasked ?? this.identificationNumberUnmasked,
      phoneNumberUnmasked: phoneNumberUnmasked ?? this.phoneNumberUnmasked,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  String toString() {
    return ''' 
        RegisterForm state:
        name: $name
        lastName: $lastName
        email: $email
        dateOfBirth: $dateOfBirth
        identificationNumber: $identificationNumber
        phoneNumber: $phoneNumber
        gender: $gender
        ''';
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());

  void setUserDataState({
    required String name,
    required String lastName,
    required String email,
    required String dateOfBirth,
    required String? identificationNumber,
    required String? identificationNumberUnmasked,
    required String? phoneNumber,
    required String? phoneNumberUnmasked,
    required String gender,
  }) {
    state = state.copyWith(
        name: name,
        lastName: lastName,
        email: email,
        dateOfBirth: dateOfBirth,
        identificationNumber: identificationNumber,
        phoneNumber: phoneNumber,
        identificationNumberUnmasked: identificationNumberUnmasked,
        phoneNumberUnmasked: phoneNumberUnmasked,
        gender: gender);

    print(state.toString());
  }

}
