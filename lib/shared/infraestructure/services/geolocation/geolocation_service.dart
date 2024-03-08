abstract class GeolocationService {
  Future getCurrentLocation();
  Future getLastKnownPosition();
  Future isLocationServiceEnabled();
  Future checkPermission();
}
