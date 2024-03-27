import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';

abstract class AuthDatasource {
  // Future<User> login(int phoneNumber);
  Future<User> sendPhoneNumber(String phoneNumber);
  Future<User> sendVerificationCode(int phoneNumber);
  Future<User> checkAuthStatus(String token);

  Future<User> register(UserRegistrationData userRegistrationData);
}

class UserRegistrationData {
  final String name;
  final String lastName;
  final String email;
  // final DateTime birthDay;
  final int dni;
  final Gender gender;
  final int phoneNumber;

  UserRegistrationData(
      {required this.name,
      required this.phoneNumber,
      required this.lastName,
      required this.email,
      // required this.birthDay,
      required this.dni,
      required this.gender});
}
