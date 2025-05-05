import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/onboarding_screen.dart';
import 'package:food_delivery/pages/auth/signup_screen.dart';
import 'package:food_delivery/service/auth_service.dart';
import 'package:food_delivery/widgets/my_button.dart';
import 'package:food_delivery/widgets/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;
  bool isPasswordHidden = true;

  void _login()async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if(!mounted) return;
    setState(() { 
      isLoading = true;
    });
    final result = await _authService.login(email, password);
    if(result == null){
      //success
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    } else {
        setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Signup failed: $result");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Membungkus dengan SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Image.asset(
                "assets/6333040.jpg",
                width: double.maxFinite,
                height: 500,
                fit: BoxFit.cover,
              ),
              // Email input
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Password input
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      isPasswordHidden ? Icons.visibility_off :
                      Icons.visibility),
                  ),
                ),
                obscureText: isPasswordHidden,
              ),
              SizedBox(height: 20),
              isLoading 
              ? Center(child: CircularProgressIndicator(),
              ) :
              SizedBox(
                width: double.maxFinite,
                child: MyButton(onTap: _login, buttontext: "Login"),
              ),
              SizedBox(height: 20),
              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => SignupScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0); // Geser dari kanan
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    child: const Text(
                      " Signup Here",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}