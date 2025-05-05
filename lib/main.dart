import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/login_screen.dart';
import 'package:food_delivery/pages/auth/signup_screen.dart';
import 'package:food_delivery/pages/home/home_scren.dart'; 
import'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url:"https://iiiegmoipcflvhkrdwhr.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlpaWVnbW9pcGNmbHZoa3Jkd2hyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYyNTI1MjgsImV4cCI6MjA2MTgyODUyOH0.D2xA7eAm2JSj3XlUuDvdUiLsBjeK4hTu0iHZmc6GiR8"
    );
    
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      home:  AuthCheck(),
    );
  }
}


class AuthCheck extends StatelessWidget {
  final supabase = Supabase.instance.client;
 AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        if (session != null) {
          return HomeScren();
        } else {
         return LoginScreen();
        }
        },
      );
     }
    }

