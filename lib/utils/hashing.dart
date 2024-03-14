import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashPassword(String password) {
  // Generate a salt (recommended to prevent rainbow table attacks)
  final salt = 'your_salt_here';
  final codec = utf8.encoder;
  final key = utf8.encode(password);
  final hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
  final digest = hmacSha256.convert(codec.convert(salt));
  return digest.toString();
}


bool verifyPassword(String enteredPassword, String storedHashedPassword) {
  final enteredPasswordHash = hashPassword(enteredPassword);
  return enteredPasswordHash == storedHashedPassword;
}
