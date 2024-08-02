import 'package:app_ciudadano_vc/config/config.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(baseUrl: Enviroments.apiUrl));

class TripServices {
  Future sendTravelRequestService(
      {required String lockId, required int userId}) async {
    final Map<String, dynamic> dataTrip = {
      "usuario_id": userId,
      "lock_id": lockId
    };
    try {
      return await dio.post('/viaje/solicitud', data: dataTrip);
    } on DioException catch (error) {
      return error.response;
    }
  }
}
