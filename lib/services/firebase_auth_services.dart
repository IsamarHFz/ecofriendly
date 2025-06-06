import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _userRef = FirebaseDatabase.instance.ref().child(
    'usuarios',
  );
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Sube una imagen a Firebase Storage y devuelve la URL de descarga
  Future<String?> uploadProfileImage(String uid, XFile imageFile) async {
    try {
      final storageRef = _storage.ref().child('fotos_perfil/$uid.jpg');

      // Subimos la imagen
      final uploadTask = await storageRef.putFile(File(imageFile.path));
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      print('✅ Imagen subida correctamente: $downloadUrl');

      // Actualizamos la base de datos con la URL de la imagen
      await _userRef.child(uid).update({'fotoPerfil': downloadUrl});

      return downloadUrl;
    } catch (e) {
      print('❌ Error al subir imagen: $e');
      return null;
    }
  }

  // Registro
  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
    String nombre,
    String grado,
    String grupo, {
    XFile? imagen,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;

      if (user != null) {
        await _userRef.child(user.uid).set({
          'nombre': nombre,
          'correo': email,
          'grado': grado,
          'grupo': grupo,
        });

        // Subimos imagen si se proporcionó
        if (imagen != null) {
          await uploadProfileImage(user.uid, imagen);
        }

        print('✅ Usuario registrado: $email ($nombre)');
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print('❌ Error al registrar: ${e.message}');
      rethrow;
    }
  }

  // Inicio de sesión
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;

      if (user != null) {
        final userData = await getUserData(user.uid);

        if (userData != null) {
          print(
            '✅ Usuario autenticado: ${userData['correo']} - Nombre: ${userData['nombre']}',
          );
        } else {
          print(
            '⚠️ Usuario autenticado pero no se encontraron datos en Realtime Database.',
          );
        }
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print('❌ Error al iniciar sesión: ${e.message}');
      rethrow;
    }
  }

  // Recopilación de datos del usuario
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final snapshot = await _userRef.child(uid).get();
      if (snapshot.exists) {
        return Map<String, dynamic>.from(snapshot.value as Map);
      } else {
        print("⚠️ No se encontraron datos para el UID: $uid");
      }
    } catch (e) {
      print("❌ Error al obtener los datos del usuario: $e");
    }
    return null;
  }
}
