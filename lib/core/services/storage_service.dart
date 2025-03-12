import 'package:shared_preferences/shared_preferences.dart';

/// Abstract storage service, CRUD funksiyalari uchun metod imzolarini belgilaydi.
abstract class StorageService {
  /// String metodlari
  Future<String?> getString(String key);

  Future<void> setString(String key, String value);

  Future<void> deleteString(String key);

  /// int metodlari
  Future<int?> getInt(String key);

  Future<void> setInt(String key, int value);

  Future<void> deleteInt(String key);

  /// bool metodlari
  Future<bool?> getBool(String key);

  Future<void> setBool(String key, bool value);

  Future<void> deleteBool(String key);

  /// Agar kerak bo'lsa, boshqa tiplar uchun metodlar (double, List<String>, va hokazo) ham qo'shilishi mumkin.
}

/// SharedPreferences asosida implementatsiya qilinadigan storage service.
class SharedPrefService implements StorageService {
  late SharedPreferences _prefs;

  // Private konstruktor
  SharedPrefService._(this._prefs);

  /// Asinxron factory metod: SharedPreferences instance'ini oladi va SharedPrefService ni qaytaradi.
  static Future<SharedPrefService> createInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefService._(prefs);
  }

  // ===== STRING METODLARI =====
  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<void> deleteString(String key) async {
    await _prefs.remove(key);
  }

  // ===== INT METODLARI =====
  @override
  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<void> deleteInt(String key) async {
    await _prefs.remove(key);
  }

  // ===== BOOL METODLARI =====
  @override
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<void> deleteBool(String key) async {
    await _prefs.remove(key);
  }
}
