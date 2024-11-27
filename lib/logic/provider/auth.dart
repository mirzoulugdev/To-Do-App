import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Foydalanuvchini ro‘yxatdan o‘tkazish
  Future<User?> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      // Firebase orqali foydalanuvchini yaratish
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Foydalanuvchini qaytarish
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // FirebaseAuthException xatoliklarini boshqarish
      throw Exception("Xatolik: ${e.message}");
    } catch (e) {
      // Boshqa xatoliklar
      throw Exception("Noma'lum xatolik: $e");
    }
  }

  /// Foydalanuvchini tizimga kirgizish
  Future<User?> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      // Firebase orqali tizimga kirish
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Foydalanuvchini qaytarish
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // FirebaseAuthException xatoliklarini boshqarish
      throw Exception("Xatolik: ${e.message}");
    } catch (e) {
      // Boshqa xatoliklar
      throw Exception("Noma'lum xatolik: $e");
    }
  }

  /// Tizimdan chiqish
  Future<void> logOut() async {
    try {
      // Firebase orqali tizimdan chiqish
      await _auth.signOut();
    } catch (e) {
      // Xatoliklarni boshqarish
      throw Exception("Tizimdan chiqishda xatolik yuz berdi: $e");
    }
  }
}
