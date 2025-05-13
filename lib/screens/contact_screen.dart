import 'package:ecofriendly/screens/base_screen.dart';
import 'package:ecofriendly/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Contáctanos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: AppTheme.foundColor,
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ExpansionTile(
                title: const Text(
                  'Información de Contacto',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                children: [
                  const ListTile(
                    title: Text(
                      'Dirección:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Calle 1234, Xaloztoc, Tlaxcala',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const ListTile(
                    title: Text(
                      'Teléfono:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '+52 123456789',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const ListTile(
                    title: Text(
                      'Correo Electrónico:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '12345678@gmail.com',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text(
                      'Síguenos en:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                          ),
                          onPressed:
                              () => _launchURL('https://www.facebook.com/'),
                        ),
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.instagram,
                            color: Color.fromARGB(255, 235, 40, 193),
                          ),
                          onPressed:
                              () => _launchURL('https://www.instagram.com/'),
                        ),
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                          ),
                          onPressed:
                              () => _launchURL('https://wa.me/2462211081'),
                        ),
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.twitter,
                            color: Colors.lightBlue,
                          ),
                          onPressed: () => _launchURL('https://twitter.com/'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildExpansionTile(String title, String content) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.transparent,
            // border: Border.all(color: const Color.fromARGB(72, 0, 0, 0)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 18.0,
              color: Color.fromARGB(255, 3, 3, 3),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      // Aquí solo se muestra un mensaje, ya no se guarda en Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario enviado con éxito')),
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(179, 255, 255, 255),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Déjanos tu mensaje',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su correo electrónico';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Por favor ingrese un correo electrónico válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Mensaje',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.message),
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su mensaje';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
