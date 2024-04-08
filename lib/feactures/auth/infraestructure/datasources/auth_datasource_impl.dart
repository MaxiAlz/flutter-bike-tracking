import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';
import 'package:dio/dio.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Enviroments.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) {
    throw UnimplementedError();
  }

  @override
  Future registerUser(UserRegistrationData userRegistrationData) async {
    try {
      final response =
          await dio.post('/auth/registro', data: userRegistrationData);

      return response.data;
    } catch (e) {
      Exception(e);
    }
  }
}
