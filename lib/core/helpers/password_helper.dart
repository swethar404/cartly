import 'dart:convert';
import 'package:crypto/crypto.dart';

class PasswordHelper {
  PasswordHelper._();

  static String hashPassword(String password) {
    return sha256.convert(
      utf8.encode(password),
    ).toString();
  }

  static bool verifyPassword({
    required String password,
    required String hashedPassword,
  }) {
    return hashPassword(password) == hashedPassword;
  }
}