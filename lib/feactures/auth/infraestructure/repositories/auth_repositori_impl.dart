import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/repositories/auth_repository.dart';
import 'package:app_ciudadano_vc/feactures/auth/infraestructure/auth_infraestructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource dataSource;

  AuthRepositoryImpl({AuthDatasource? datasource})
      : dataSource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  // @override
  // Future<User> register( userRegistrationData) {
  //   return dataSource.register( );
  // }

  @override
  Future<User> sendPhoneNumber(String phoneNumber) {
    return dataSource.sendPhoneNumber(phoneNumber);
  }

  @override
  Future<User> sendVerificationCode(String phoneNumber) {
    // TODO: implement sendVerificationCode
    throw UnimplementedError();
  }
}
