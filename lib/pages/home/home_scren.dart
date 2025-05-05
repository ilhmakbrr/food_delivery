import 'package:flutter/material.dart';
import 'package:food_delivery/service/auth_service.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({super.key});

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          ElevatedButton(
            onPressed: () => authService.logout(context),
            child: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }
} 