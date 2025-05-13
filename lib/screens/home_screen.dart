import 'package:flutter/material.dart';
import 'package:ecofriendly/screens/login_screen.dart';
import 'package:ecofriendly/screens/sign_up_screens.dart';
import 'package:ecofriendly/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<HomeScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(backgroundColor: Colors.transparent, body: _page()),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 50.0),
            _signInButton(),
            const SizedBox(height: 30.0),
            _createAccountButton(),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.iconColor, width: 2),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, color: AppTheme.iconColor, size: 120.0),
    );
  }

  // Widgets de Usuario y contraseña
  Future<Widget> _inputField(
    String hintText,
    TextEditingController controller, {
    isPassword = false,
  }) async {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18.0),
      borderSide: const BorderSide(color: AppTheme.iconColor),
    );
    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  // Botón de inicio de sesión
  Widget _signInButton() {
    return ElevatedButton(
      onPressed: () {
        final ds1 = MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );
        Navigator.push(context, ds1);
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: AppTheme.buttonColor,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Iniciar sesión",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: AppTheme.iconColor),
        ),
      ),
    );
  }

  Widget _createAccountButton() {
    return ElevatedButton(
      onPressed: () {
        final route2 = MaterialPageRoute(
          builder: (context) {
            return const SignUp();
          },
        );
        Navigator.push(context, route2);
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: AppTheme.buttonColor,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Crear cuenta",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: AppTheme.iconColor),
        ),
      ),
    );
  }
}
