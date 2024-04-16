abstract class KeyValueStorageService {
  Future<void> setAnyKeyValue<T>(String key, T value);
  Future<void> setStringKeyValue(String key, String value);
  Future<T?> getKeyValue<T>(String key);
  Future<bool> removeKey(String key);
}
