import 'package:auth/auth_mock.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  void _logout(BuildContext context) {
    mockAuthService.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(context) {
    return FutureBuilder(
      future: mockAuthService.isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _loading();
        }

        if (snapshot.data == true) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('home'),
              actions: [
                IconButton(onPressed: () => _logout(context), icon: const Icon(Icons.logout)),
              ],
            ),
            body: const Center(
              child: Text('Welcome to home page'),
            ),
          );
        } else {
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacementNamed(context, '/login');
          });
          return _loading();
        }
      },
    );
  }

  Widget _loading() {
    return const Scaffold(
      body:  Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
