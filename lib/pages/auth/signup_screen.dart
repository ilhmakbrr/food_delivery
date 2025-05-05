import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/login_screen.dart';
import 'package:food_delivery/service/auth_service.dart';
import 'package:food_delivery/widgets/my_button.dart';
import 'package:food_delivery/widgets/snack_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;
  bool isPasswordHidden = true;

  void _signUp()async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    
    // validate email formate
  if(!email.contains(".com")){
    showSnackBar(context, "Invalid email, it must contain .com");
    }
    setState(() {
      isLoading = true;
    });
    final result = await _authService.signup(email, password);
    if(result == null){
      //success
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Signup success ! now turn to login");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
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
                "assets/3d-render-secure-login-password-illustration.jpg",
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
                    icon: Icon(isPasswordHidden ? Icons.visibility_off :
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
                child: MyButton(onTap: _signUp, buttontext: "Signup"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
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
                      " Login Here",
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