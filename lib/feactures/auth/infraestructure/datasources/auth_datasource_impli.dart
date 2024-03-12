import 'package:app_ciudadano_vc/config/constants/enviroments.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';
import 'package:app_ciudadano_vc/feactures/auth/infraestructure/auth_infraestructure.dart';
import 'package:dio/dio.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Enviroments.apiUrl));

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
  Future<User> sendPhoneNumber(String phoneNumber) async {
    try {
      final response = await dio.post('/auth/local',
          data: {'identifier': phoneNumber, 'password': phoneNumber});

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
    } catch (e) {
      throw WrongCredentials();
    }

    // throw UnimplementedError();
  }

  @override
  Future<User> sendVerificationCode(int phoneNumber) {
    // TODO: implement sendVerificationCode
    throw UnimplementedError();
  }
}
