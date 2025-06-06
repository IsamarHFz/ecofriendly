import 'package:ecofriendly/screens/home_screen.dart'; // 👈 Importamos HomeScreen
import 'package:ecofriendly/screens/menu_screen.dart';
import 'package:ecofriendly/services/firebase_auth_services.dart';
import 'package:ecofriendly/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reEnterPassController = TextEditingController();
  final TextEditingController gradoController = TextEditingController();
  final TextEditingController grupoController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  void seleccionarImagen() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
      });
    }
  }

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

        print('📥 Datos ingresados: email=$email, pass=$password');

        if ([
          email,
          password,
          rePassword,
          nombre,
          grado,
          grupo,
        ].any((e) => e.isEmpty)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Por favor, complete todos los campos'),
            ),
          );
          return;
        }

        if (password != rePassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Las contraseñas no coinciden')),
          );
          return;
        }

        try {
          print('⏳ Intentando registrar usuario...');
          final user = await _authService.signUpWithEmailAndPassword(
            email,
            password,
            nombre,
            grado,
            grupo,
          );
          print('✅ Usuario creado: $user');

          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MenuScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No se pudo registrar el usuario')),
            );
          }
        } on FirebaseAuthException catch (e) {
          print('❌ Error de Firebase: ${e.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error de autenticación: ${e.message}')),
          );
        } catch (e) {
          print('❌ Error inesperado: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error inesperado al registrar')),
          );
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
