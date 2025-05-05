import 'package:flutter/material.dart';
import 'package:food_delivery/utils/consts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body : Stack(
        children: [
          Container(
            height: size.height, 
            width: size.width, 
            color: imageBackground,
            child: Image.asset(
              "assets/food-delivery/freepik__adjust__5822.png",
            color : imageBackground2,
            repeat: ImageRepeat.repeatY,
            ),
           ),
           Positioned(
            top: -80,
            right: 0,
            left: 0,
            child: Image.asset("assets/food-delivery/52c06ec176eb1f2011b8a0bbe978503b.png",fit: BoxFit.cover,),
          ),
          Positioned(
            top: 55,
            right: 55,
            child: Image.asset("assets/food-delivery/burgerfloating.png",width: 200, height: 200,),
          ),
          Positioned(
            top: 145,
            right: 5,
            child: Image.asset("assets/food-delivery/pizafloating.png",width: 200, height: 200,),
          ),
        ],
      )
    );
    
  }
}
//desain onboarding screen
