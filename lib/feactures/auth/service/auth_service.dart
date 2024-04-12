import 'package:app_ciudadano_vc/config/constants/enviroments.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(baseUrl: Enviroments.apiUrl));

class AuthServices {
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

  Future verifyCodeService({required String phoneNumber, required String code}) async {
    final Map<String, dynamic> vorifyCodeData = {
      "numero": phoneNumber,
      "codigo": code
    };

    try {
      final verifyCodeSericeResponse =
          await dio.post('/auth/verificacion_codigo', data: vorifyCodeData);
      return verifyCodeSericeResponse;
    } on DioException catch (error) {
      return error.response;
    }
  }
}
