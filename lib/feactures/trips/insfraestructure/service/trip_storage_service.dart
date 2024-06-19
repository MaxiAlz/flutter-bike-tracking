import 'package:app_ciudadano_vc/config/constants/app_constants.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/share_infraestructure.dart';

class TripStorageService {
  final internalStorage = KeyValueStorageImpl();
  final appConstants = AppConstants();

  Future<void> saveTripStatus({required String status}) async {
    return internalStorage.getKeyValue(appConstants.tripStatusKey);
  }

  Future<void> saveStartTime({required int startTime}) async {
    await internalStorage.setAnyKeyValue(appConstants.tripStatusKey, startTime);
  }

  Future<int?> getStartTime() async {
    internalStorage.getKeyValue(appConstants.tripStatusKey);
    return null;
  }
}
