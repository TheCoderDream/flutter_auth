import 'package:auth/auth_mock.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      User? user = await mockAuthService.login(email, password);
      if (user == null) {
        _errorMessage = '';
        Navigator.pushReplacementNamed(context, '/');
      } else {
        setState(() {
          _errorMessage = 'Invalid email or password';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = (error as dynamic).message;
      });
    }

  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(36),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email'
                ),
              ),
              const SizedBox(height: 16,),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Password'
                ),
              ),
              const SizedBox(height: 16,),
              ElevatedButton(onPressed: _login, child: const Text('Login')),
              Text(
                _errorMessage,
                style: const TextStyle(
                    color: Colors.red
                ),
              ),
              TextButton(onPressed: () {
                Navigator.pushNamed(context, '/signup');
              }, child: const Text('Don\'t have an account? Sign up'))
            ],
          ),
        ),
      ),
    );
  }
}