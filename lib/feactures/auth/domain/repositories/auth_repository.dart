import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';

abstract class AuthRepository {
  // Future<User> login(int phoneNumber);
  Future<User> sendPhoneNumber(String phoneNumber);
  Future<User> sendVerificationCode(String phoneNumber);
  Future<User> checkAuthStatus(String token);
  // Future<User> register(UserRegistrationData userRegistrationData);
}

class UserRegistrationData {
  final String name;
  final String fullName;
  final String email;
  final DateTime birthDay;
  final int dni;
  final Gender gender;

  UserRegistrationData(
      {required this.name,
      required this.fullName,
      required this.email,
      required this.birthDay,
      required this.dni,
      required this.gender});
}
