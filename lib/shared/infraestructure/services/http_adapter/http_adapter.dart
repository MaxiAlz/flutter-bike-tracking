abstract class HttpAdapter {
  Future<void> getHttp({required String path});
  Future<void> postHttp(
      {required String path, required Map<String, dynamic> body});
  Future<void> deleteHttp();
  Future<void> updateHttp();
}
