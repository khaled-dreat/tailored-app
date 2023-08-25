// import 'package:compitition/core/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../sevices/firebase_fireStore/firebase_service.dart';
// import '../commpititions/competition_screen.dart';
// import 'components/custom_button.dart';

// class WelcomeScreen extends StatelessWidget {
//   final FirestoreService firestoreService = FirestoreService();
//   WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//         //  SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Spacer(flex: 2), //2/6
//                   Text(
//                     "Hello User,",
//                     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "Let's Play Quiz,",
//                     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                         color: Colors.white70, fontWeight: FontWeight.bold),
//                   ),
//                   const Spacer(),

//                   CustomButton(
//                     text: 'Lets Start a Quiz',
//                     onTap: () async {
              
//                       Get.off(() => const CompetitionScreen());
//                     },
//                   ),
//                   const Spacer(flex: 2), // it will take 2/6 spaces
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
