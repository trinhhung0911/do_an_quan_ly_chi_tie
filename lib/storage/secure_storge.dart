import 'dart:core';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class SecureStorage {
  final _storage = const FlutterSecureStorage();
  static const userId = 'USER_ID';
  static const email='EMAIL';
  Future<void> saveString({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }
  Future<String?> getString({required String key}) async {
    return await _storage.read(key: key);
  }



}
