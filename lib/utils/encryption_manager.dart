import 'package:encrypt/encrypt.dart';

class EncryptionManager {

  final String encryption_key = "dIaOAjNzEHoxY6odqzAOaePmwe4mSBbr";
  encryption({required String plainText}) {
    final key = Key.fromUtf8(encryption_key);
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return "${encrypted.base16},${iv.base16}";
  }
  decryption({required String decrypted}) {
    var decryptedArr = decrypted.split(',');
    final encrypter = Encrypter(AES(Key.fromUtf8(encryption_key)));
    return encrypter.decrypt(Encrypted.fromBase16(decryptedArr[0]),
        iv: IV.fromBase16(decrypted[1]));
  }
}
