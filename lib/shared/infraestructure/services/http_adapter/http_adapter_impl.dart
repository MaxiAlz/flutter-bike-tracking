import 'package:app_ciudadano_vc/config/constants/enviroments.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/http_adapter/http_adapter.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/shared_preferences/key_value_storage_impl.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(baseUrl: Enviroments.apiUrl));

class Api extends HttpAdapter {
  final setKeyValue = KeyValueStorageImpl();

  @override
  Future getHttp({required String path}) async {
    final userToken = await setKeyValue.getKeyValue<String>('userToken');
    try {
      final response = await dio.get(path,
          options: Options(headers: {
            'Authorization': 'Bearer $userToken',
          }));

      return response;
    } on DioException catch (dioError) {
      return dioError.response;
    } catch (error) {
      return error;
    }
  }

  @override
  Future<void> deleteHttp() {
    // TODO: implement deleteHttp
    throw UnimplementedError();
  }

  @override
  Future<void> postHttp(
      {required String path, required Map<String, dynamic> body}) {
    // TODO: implement postHttp
    throw UnimplementedError();
  }

  @override
  Future<void> updateHttp() {
    // TODO: implement updateHttp
    throw UnimplementedError();
  }
}
