import 'package:auth/home_screen.dart';
import 'package:auth/login_screen.dart';
import 'package:auth/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AuthApp());
}

class AuthApp extends StatelessWidget {

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SingupPage()
      },
    );
  }
}
