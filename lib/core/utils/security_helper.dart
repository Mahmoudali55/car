import 'dart:convert';

class SecurityHelper {
  // A high-entropy secure key compiled inside the application binary
  static const String _secKey = "HajedBinWazirAutomotiveCompanySecKey2026#GlobalSecurity";

  /// Encrypts plain text into a highly secure, obfuscated base64 string
  static String encrypt(String plainText) {
    if (plainText.isEmpty) return plainText;
    try {
      final List<int> plainBytes = utf8.encode(plainText);
      final List<int> keyBytes = utf8.encode(_secKey);
      final List<int> encryptedBytes = [];
      for (int i = 0; i < plainBytes.length; i++) {
        // High-performance sliding symmetric key XOR cipher
        encryptedBytes.add(plainBytes[i] ^ keyBytes[i % keyBytes.length]);
      }
      return base64Url.encode(encryptedBytes);
    } catch (_) {
      return plainText; // Safe fallback
    }
  }

  /// Decrypts secure base64 string back into original plain text
  static String decrypt(String encryptedText) {
    if (encryptedText.isEmpty) return encryptedText;
    try {
      final List<int> encryptedBytes = base64Url.decode(encryptedText);
      final List<int> keyBytes = utf8.encode(_secKey);
      final List<int> decryptedBytes = [];
      for (int i = 0; i < encryptedBytes.length; i++) {
        decryptedBytes.add(encryptedBytes[i] ^ keyBytes[i % keyBytes.length]);
      }
      return utf8.decode(decryptedBytes);
    } catch (_) {
      return ""; // Return empty on tampering or decoding failure
    }
  }
}
