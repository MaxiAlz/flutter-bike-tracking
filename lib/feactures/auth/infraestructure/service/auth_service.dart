import 'package:app_ciudadano_vc/config/constants/enviroments.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(baseUrl: Enviroments.apiUrl));

class AuthServices extends AuthServicesDomain {
  @override
  Future sendPhoneService(String phoneNumber) async {
    final Map<String, dynamic> phoneData = {"numero": phoneNumber};

    try {
      final response =
          await dio.post('/auth/verificacion_telefono', data: phoneData);

      return response;
    } on DioException catch (error) {
      return error.response;
    }
  }

  @override
  Future verifyCodeService({
    required String phoneNumber,
    required String code,
  }) async {
    final Map<String, dynamic> verifyCodeData = {
      "numero": phoneNumber,
      "codigo": code
    };

    try {
      final verifyCodeSericeResponse =
          await dio.post('/auth/verificacion_codigo', data: verifyCodeData);
      return verifyCodeSericeResponse;
    } on DioException catch (error) {
      return error.response;
    }
  }

  @override
  Future checkAuthStatusService(String token) async {
    try {
      final response = await dio.get('/auth/perfil',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      return response;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) throw Exception('Token no valido');
    } catch (error) {
      throw Exception(error);
    }
  }
}
