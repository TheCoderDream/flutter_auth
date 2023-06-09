import 'dart:convert';
import 'package:auth/storage.dart';
import 'dart:math';

String generateUniqueId() {
  final timestamp = DateTime.now().microsecondsSinceEpoch.toString();
  final random = Random().nextInt(999999).toString().padLeft(6, '0');
  return '$timestamp$random';
}


class User {
  final String id;
  final String email;
  final String password;

  User({ required this.id, required this.email, required this.password });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password
    };
  }
}

abstract class Auth {
  Future<User?> login(String email, String password);
  Future<User?> signup(String email, String password);
  Future<void> logout();
}

class MockAuth implements Auth {

  Future<bool> isLoggedIn() async => await getFromStorage('users') != null;

  Future<User?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final user = await findUserByEmail(email);


    if (user == null) {
      throw Exception('Invalid Credentials');
    } else {
      if (user.password == password && user.email == email) {
        return user;
      } else {
        throw Exception('Invalid Credentials');
      }
    }
  }

  @override
  Future<void> logout() async {
    await clearStorage();
  }

  @override
  Future<User?> signup(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final user = User(id: generateUniqueId(), email: email, password: password);

    await saveUser(user);

    return user;
  }

}

final mockAuthService = MockAuth();