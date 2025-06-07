import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendEmail(String name, String email, String message) async {
  const serviceId = 'service_gl47oja';
  const templateId = 'template_99de54z';
  const userId = 'JtEkV3Ls2d-wZTo3t';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  final response = await http.post(
    url,
    headers: {'origin': 'http://localhost', 'Content-Type': 'application/json'},
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'from_name': name,
        'from_email': email,
        'message': message,
      },
    }),
  );

  if (response.statusCode == 200) {
    print('✅ Correo enviado exitosamente');
  } else {
    print('❌ Error al enviar correo: ${response.body}');
  }
}
