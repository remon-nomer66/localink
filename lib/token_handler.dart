
import 'dart:convert';

// Mock database for storing user data and tokens.
// This should be replaced by a secure storage mechanism in a real application.
Map<String, dynamic> database = {};

String generateToken(String userId) {
  final token = base64Encode(utf8.encode(userId + DateTime.now().toIso8601String()));
  final expiryDate = DateTime.now().add(const Duration(hours: 24));

  // Store the token and its expiry date in the database
  database[userId] = {
    'token': token,
    'expiryDate': expiryDate.toIso8601String(),
  };

  return token;
}

bool isTokenValid(String userId, String token) {
  if (database.containsKey(userId)) {
    final storedToken = database[userId]['token'];
    final storedExpiryDate = DateTime.parse(database[userId]['expiryDate']);

    if (storedToken == token && DateTime.now().isBefore(storedExpiryDate)) {
      return true;
    }
  }
  return false;
}

void saveUserCredentials(String userId, String password) {
  // In a real application, you should hash the password before storing it.
  database[userId] = {
    'password': password
  };
}

bool checkUserCredentials(String userId, String password) {
  if (database.containsKey(userId) && database[userId]['password'] == password) {
    return true;
  }
  return false;
}
