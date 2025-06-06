import 'package:ecofriendly/screens/menu_screen.dart';
import 'package:ecofriendly/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.ref().child('usuarios');

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reEnterPassController = TextEditingController();
  final TextEditingController gradoController = TextEditingController();
  final TextEditingController grupoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50.0),
                  _icon(),
                  const SizedBox(height: 30.0),
                  _inputField("Usuario", usernameController),
                  const SizedBox(height: 20.0),
                  _inputField("Email", emailController),
                  const SizedBox(height: 20.0),
                  _inputField("Grado", gradoController),
                  const SizedBox(height: 20.0),
                  _inputField("Grupo", grupoController),
                  const SizedBox(height: 20.0),
                  _inputField(
                    "Contraseña",
                    passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20.0),
                  _inputField(
                    "Escriba nuevamente la contraseña",
                    reEnterPassController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 30.0),
                  _signUpButton(),
                ],
              ),
            ),
          ),
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

  Widget _inputField(
    String hintText,
    TextEditingController controller, {
    bool isPassword = false,
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

  Widget _signUpButton() {
    return ElevatedButton(
      onPressed: () async {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final rePassword = reEnterPassController.text.trim();
        final nombre = usernameController.text.trim();
        final grado = gradoController.text.trim();
        final grupo = grupoController.text.trim();

        if (password != rePassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Las contraseñas no coinciden')),
          );
          return;
        }

        try {
          // Crear cuenta en Firebase Authentication
          UserCredential userCredential = await _auth
              .createUserWithEmailAndPassword(email: email, password: password);

          // Guardar datos adicionales en Realtime Database
          await _database.child(userCredential.user!.uid).set({
            'nombre': nombre,
            'correo': email,
            'grado': grado,
            'grupo': grupo,
          });

          // Redirigir al menú principal
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MenuScreen()),
          );
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.buttonColor,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Registrarse",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: AppTheme.iconColor),
        ),
      ),
    );
  }
}
