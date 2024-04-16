import 'package:app_ciudadano_vc/config/constants/enviroments.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/http_adapter/http_adapter.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(baseUrl: Enviroments.apiUrl));

class HttpAdapterImpl extends HttpAdapter {
  @override
  Future<void> deleteHttp() {
    // TODO: implement deleteHttp
    throw UnimplementedError();
  }

  @override
  Future<void> getHttp({required String path}) {
    // TODO: implement getHttp
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
