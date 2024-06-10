import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class EncryptApi {
// Function to encode (encrypt) the content
  static String encode({required String key, required String contentToEncode}) {
    final keyBytes = utf8.encode(key);
    final sha256Key = sha256.convert(keyBytes).bytes;
    final aesKey = encrypt.Key(Uint8List.fromList(sha256Key));

    final iv = encrypt.IV.fromLength(16); // Initialization vector
    final encrypter = encrypt.Encrypter(encrypt.AES(aesKey));

    final encrypted = encrypter.encrypt(contentToEncode, iv: iv);

    final combinedBytes = iv.bytes + encrypted.bytes;
    return base64.encode(combinedBytes);
  }

  // Function to decode (decrypt) the content
  static String decode({required String key, required String encodedContent}) {
    final keyBytes = utf8.encode(key);
    final sha256Key = sha256.convert(keyBytes).bytes;
    final aesKey = encrypt.Key(Uint8List.fromList(sha256Key));

    final contentBytes = base64.decode(encodedContent);
    final iv = encrypt.IV(Uint8List.fromList(contentBytes.sublist(0, 16)));
    final encryptedBytes = contentBytes.sublist(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(aesKey));

    final decrypted = encrypter
        .decrypt(encrypt.Encrypted(Uint8List.fromList(encryptedBytes)), iv: iv);

    return decrypted;
  }
}
