import 'package:auth/auth_mock.dart';
import 'package:flutter/material.dart';

bool validateEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
  return emailRegex.hasMatch(email);
}

bool validatePassword(String password) {
  // Password must be at least 8 characters long
  if (password.length < 8) {
    return false;
  }

  // Password must contain at least one uppercase letter
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }

  // Password must contain at least one lowercase letter
  if (!password.contains(RegExp(r'[a-z]'))) {
    return false;
  }

  // Password must contain at least one digit
  if (!password.contains(RegExp(r'[0-9]'))) {
    return false;
  }

  // Password must contain at least one special character
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return false;
  }

  // All requirements met, password is valid
  return true;
}

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});


  @override
  _SingupPageState createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Singup'),
      ),
      body: Container(
        padding: const EdgeInsets.all(36),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email'
                  ),
                  validator: (value) {
                    if (!validateEmail(value ?? '')) {
                      return 'Invalid Email';
                    }
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password'
                  ),
                  validator: (password) {
                    if (validatePassword(password ?? '')) {
                      return 'Invalid Password';
                    }
                  },
                ),
                SizedBox(height: 16,),
                ElevatedButton(
                  onPressed: () async {
                    final user = await mockAuthService.signup(emailController.text, passwordController.text);
                    if (user != null) {
                      Navigator.pushNamed(context, '/');
                    }
                  }, child: Text('Sign up!'),
                ),
                SizedBox(height: 16,),
                TextButton(onPressed: () {
                  Navigator.pushNamed(context, '/login');
                }, child: const Text('Already have an account? Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}