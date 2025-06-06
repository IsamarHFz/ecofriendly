import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecofriendly/screens/menu_screen.dart';
import 'package:ecofriendly/screens/login_screen.dart';

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Verificación
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Si está logueado
          if (snapshot.hasData) {
            return const MenuScreen();
          }

          // Si no hay sesión activa
          return const LoginScreen();
        },
      ),
    );
  }
}
