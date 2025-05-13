import 'package:ecofriendly/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecofriendly/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            _inputField("Usuario", usernameController),
            const SizedBox(height: 30.0),
            _inputField("Contraseña", passwordController, isPassword: true),
            const SizedBox(height: 50.0),
            _signInButton(),
            const SizedBox(height: 30.0),
            _passText(),
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
      child: ClipOval(
        child: Image.asset(
          'assets/images/logo.jpeg', // Asegúrate de que la ruta sea correcta
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover, // Ajusta la imagen dentro del círculo
        ),
      ),
    );
  }

  // Widgets de Usuario y contraseña
  Widget _inputField(
    String hintText,
    TextEditingController controller, {
    isPassword = false,
  }) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18.0),
      borderSide: const BorderSide(color: AppTheme.iconColor),
    );
    return TextField(
      style: const TextStyle(color: AppTheme.iconColor),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppTheme.iconColor),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  // Botón de inicio de sesión
  Widget _signInButton() {
    return ElevatedButton(
      // Mostrar datos en debug console
      onPressed: () {
        debugPrint("Usuario: " + usernameController.text);
        debugPrint("Contraseña: " + passwordController.text);

        final route2 = MaterialPageRoute(
          builder: (context) {
            return const MenuScreen();
          },
        );
        Navigator.push(context, route2);
      },
      style: ElevatedButton.styleFrom(
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

  Widget _passText() {
    return const Text(
      "¿Has olvidado la contraseña?",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16.0, color: AppTheme.textColor),
    );
  }
}
