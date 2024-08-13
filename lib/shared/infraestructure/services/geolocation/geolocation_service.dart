abstract class GeolocationService {
  Future getCurrentLocation();
  Future getLastKnownPosition();
  Future isLocationServiceEnabled();
  Future checkPermission();
  Stream<bool> getServiceStatusStream();
}
