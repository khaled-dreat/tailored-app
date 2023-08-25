// // ignore_for_file: prefer_const_constructors
// import 'dart:math';

// import 'package:flutter/material.dart';

// import '../../../core/constants/size_config.dart';
// import '../widgets/socal_buttons.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   bool isSign = false;
//   late AnimationController _animationController;
//   late Animation<double> _rotate;

//   void setUpAnimation() {
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//     _rotate =
//         Tween<double>(begin: 0, end: -pi / 2).animate(_animationController);
//   }

//   void updateScreen() {
//     setState(() {
//       isSign = !isSign;
//     });
//     isSign ? _animationController.forward() : _animationController.reverse();
//   }

//   @override
//   void initState() {
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

//     super.initState();
//     setUpAnimation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     final screenWidth = SizeConfig.screenWidth;
//     final screenHeight = SizeConfig.screenHeight;
//     return Scaffold(
//       body:
//       Center(child: SocialButton(isSignIn: isSign)),
//       //  AnimatedBuilder(
//       //   animation: _rotate,
//       //   builder: (context, child) => SingleChildScrollView(
//       //     child: Stack(
//       //       children: [
//       //         // _login(screenHeight, screenWidth),
//       //         // _signIn(screenWidth, screenHeight),
//       //         setVerticalSpace(5),
//       //         _socalBottons(screenWidth),
//       //         // _titleLogin(screenWidth, screenHeight),
//       //         // _titleSignUp(screenWidth, screenHeight),
//       //       ],
//       //     ),
//       //   ),
//       // ),
    
    
//     );
//   }

  

//   AnimatedPositioned _socalBottons(double screenWidth) {
//     return AnimatedPositioned(
//       duration: Duration(milliseconds: 300),
//       left: isSign ? screenWidth * 0.1 : 0,
//       right: isSign ? 0 : screenWidth * 0.12,
//       bottom: screenWidth * 0.3,
//       child: SocialButton(isSignIn: isSign),
//     );
//   }

//     }