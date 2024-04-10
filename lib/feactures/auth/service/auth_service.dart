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
      return error;
    }
  }
}
