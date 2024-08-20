import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/trips/domain/entities/viaje_entity.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/share_infraestructure.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(baseUrl: Enviroments.apiUrl));
final api = Api();

class TripServices {
  Future sendTravelRequestService(
      {required String trackerCodigo, required int userId}) async {
    final Map<String, dynamic> dataTrip = {
      "usuario_id": userId,
      "tracker_codigo": trackerCodigo
    };
    try {
      return await dio.post('/viaje/solicitud', data: dataTrip);
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future<MyTripsPaginated> getMyTrips() async {
    try {
      final apiResponse = await api.getHttp(path: '/viaje');
      return MyTripsPaginated.fromJson(apiResponse.data);
    } catch (e) {
      throw Exception('Failed to load trips: $e');
    }
  }
}