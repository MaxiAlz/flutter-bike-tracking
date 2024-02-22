import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> register(UserRegistrationData userRegistrationData) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<User> sendPhoneNumber(int phoneNumber) {
    // TODO: implement sendPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<User> sendVerificationCode(int phoneNumber) {
    // TODO: implement sendVerificationCode
    throw UnimplementedError();
  }

}
