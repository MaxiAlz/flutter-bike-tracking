import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';

abstract class AuthDatasource {
  // Future<User> login(int phoneNumber);
  // Future<User> sendPhoneNumber(String phoneNumber);
  // Future<User> sendVerificationCode(int phoneNumber);
  Future<User> checkAuthStatus(String token);
  Future registerUser(UserRegistrationData userRegistrationData);
}
