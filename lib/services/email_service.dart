import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendOrderEmail(
  String nombre,
  String telefono,
  String email,
  String producto,
  String precio,
) async {
  String username = 'tuemail@gmail.com';
  String password = 'tu-contraseña-app';

  final smtpServer = gmail(username, password);

  final message =
      Message()
        ..from = Address(username, 'Tu App Ecofriendly')
        ..recipients.add(username)
        ..subject = 'Nuevo pedido de $nombre'
        ..text =
            'Cliente: $nombre\nTeléfono: $telefono\nEmail: $email\nProducto: $producto\nPrecio: $precio';

  try {
    final sendReport = await send(message, smtpServer);
    print('Correo enviado: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Error al enviar correo: $e');
  }
}
