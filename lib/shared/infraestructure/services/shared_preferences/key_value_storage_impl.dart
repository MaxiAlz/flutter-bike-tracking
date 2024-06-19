import 'package:app_ciudadano_vc/shared/infraestructure/services/shared_preferences/key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSahrePrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getKeyValue<T>(String key) async {
    final prefs = await getSahrePrefs();

    switch (T) {
      case int:
        return prefs.getInt(key) as T?;

      case String:
        return prefs.getString(key) as T?;

      case bool:
        return prefs.getBool(key) as T?;

      default:
        throw UnimplementedError(
            '(no se hay seteo para este tipo de dato) =>set not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSahrePrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setAnyKeyValue<T>(String key, T value) async {
    final prefs = await getSahrePrefs();

    switch (T) {
      case int:
        prefs.setInt(key, value as int);
        break;
      case String:
        prefs.setString(key, value as String);
        break;
      case bool:
        prefs.setBool(key, value as bool);

      default:
        throw UnimplementedError(
            '(no se hay seteo para este tipo de dato) =>set not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<void> setStringKeyValue(String key, String value) async {
    final prefs = await getSahrePrefs();
    prefs.setString(key, value);
  }
}
