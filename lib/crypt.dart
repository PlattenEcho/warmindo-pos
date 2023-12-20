import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() {
  String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  String get;

  get = encryptPassword("123456");
  print(get);
}
