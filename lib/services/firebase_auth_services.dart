import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _userRef = FirebaseDatabase.instance.ref().child(
    'usuarios',
  );
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Registro
  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
    String nombre,
    String grado,
    String grupo,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;

      if (user != null) {
        print('🔵 Usuario creado. UID: ${user.uid}');

        // Verifica conexión con Realtime Database
        await _userRef
            .child(user.uid)
            .set({
              'nombre': nombre,
              'correo': email,
              'grado': grado,
              'grupo': grupo,
            })
            .then((_) {
              print('🔥 Guardado exitoso');
            })
            .catchError((e) {
              print('💥 Error al guardar en RTDB: $e');
            });

        print('✅ Datos guardados en Realtime Database');

        return user;
      }

      return null;
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ Error inesperado al registrar: $e');
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
          print('✅ Usuario autenticado: ${userData['correo']}');
        } else {
          print('⚠️ Usuario autenticado pero sin datos en Realtime Database');
        }
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ Error inesperado: $e');
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
