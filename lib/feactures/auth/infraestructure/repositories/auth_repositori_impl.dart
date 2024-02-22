import 'package:app_ciudadano_vc/feactures/auth/domain/entities/user.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
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
