import 'dart:convert';

import 'package:auth/auth_mock.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveToStorage(String key, String value) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.setString(key, value);
}

Future<String?> getFromStorage(String key) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(key);
}

Future<bool> clearStorage() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.clear();
}

Future<bool> deleteFromStorage(String key) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.remove(key);
}

Future<List<User>?> getUsers() async {
  final usersJson = await getFromStorage('users');
  if (usersJson != null) {
    final users = jsonDecode(usersJson) as Map<String, User>;
    return users.values.toList();
  }
}

Future<void> saveUser(User user) async {
  final usersJson = await getFromStorage('users');
  if (usersJson != null) {
    final users = jsonDecode(usersJson) as Map<String, User>;
    users[user.id] = user;
    saveToStorage('users', jsonEncode(users));
  } else {
    final map = {user.id: user.toJson()};
    saveToStorage('users', jsonEncode(map));
  }
}


Future<User?> findUserByEmail(String email) async {
  final users = await getUsers();

  return users?.firstWhere((user) => user.email == email);
}