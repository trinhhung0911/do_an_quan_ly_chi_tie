import 'dart:core';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();
  static const userId = 'USER_ID';
  Future<void> saveString({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }
  Future<String?> getString({required String key}) async {
    return await _storage.read(key: key);
  }
  Future<void> deleteString({required String key}) async {
    return _storage.delete(key: key);
  }
  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }

}
