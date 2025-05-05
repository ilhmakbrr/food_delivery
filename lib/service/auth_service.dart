import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final suabase = Supabase.instance.client;
  //sign up function

  Future<String?>signup(String email, String password) async {
    try {
      final response = await suabase.auth.signUp(
        email: email, 
        password: password
        );
      if (response.user != null) {
        return null;
      }
      return "An Uknown error occurred";
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Error:$e";
    }
  }
// login Function
  Future<String?>login(String email, String password) async {
    try {
      final response = await suabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return null;
      }
      return "Invalid email or password"; 
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Error:$e";
    }
  }
  // logout function
  Future<void> logout(BuildContext context) async {
    try {
      await suabase.auth.signOut();
      if (!context.mounted) return;
    Navigator.of(
      context,
      ).pushReplacement(
        MaterialPageRoute(
        builder: (_) => LoginScreen()));
    } catch (e) {
      print("Logout Error $e");
    }
  }
}