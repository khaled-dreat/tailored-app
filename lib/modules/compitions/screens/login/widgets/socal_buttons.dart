// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../../../core/constants/size_config.dart';
// import '../../../core/widgets/custom_text.dart';
// import '../../../view_models/auth/auth_view_model.dart';
// import '../../commpititions/competition_screen.dart';

// class SocialButton extends StatelessWidget {
//   bool isSignIn = false;
//   SocialButton({Key? key, required this.isSignIn}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         User currentFireBaseUser = await signInWithGoogle();
        
//       //   Navigator.pushReplacementNamed(context, Routes.home);
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const CompetitionScreen(),));
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CustomText(
//             text: 'Sing in with Google      ',
//             color: isSignIn ? Colors.white : Colors.white,
//             fontSize: 20,
//           ),
//           setVerticalSpace(2),
//           Icon(
//             FontAwesomeIcons.google,
//             color: isSignIn ? Colors.white : Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }
