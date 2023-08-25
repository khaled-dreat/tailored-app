// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// import '../constants/constants.dart';
// import '../constants/size_config.dart';
// import 'custom_text.dart';

// class ShowDialog {
//   static void showMyDialog(
//     BuildContext context, {
//     required String title,
//     required String discription,
//     IconData? icon,
//     required String? choiceTrue,
//     String? choiceFalse,
//     double? height,
//     required void Function()? onChoiceTrue,
//     void Function()? onChoiceFalse,
//   }) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Expanded(
//           child: Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   height: height ?? 200,
//                   decoration: BoxDecoration(
//                     color: kPrimaryColor.withOpacity(0.8),
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       setVerticalSpace(3),
//                       CustomText(
//                         text: title,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                       setVerticalSpace(3),
//                       CustomText(
//                         text: discription,
//                         fontSize: 16,
//                         alignment: Alignment.center,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white70,
//                       ),
//                       const Spacer(
//                         flex: 1,
//                       ),
//                       Row(
//                         children: [
//                           const Spacer(),
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context, true);
//                             },
//                             child: CustomText(
//                               text: choiceTrue!,
//                               fontSize: 12,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Spacer(),
//                           if (choiceFalse != null)
//                             ElevatedButton(
//                               style: ButtonStyle(
//                                   backgroundColor: MaterialStateProperty.all(
//                                       kPrimaryDarkColor)),
//                               child: CustomText(
//                                 text: choiceFalse,
//                                 fontSize: 12,
//                               ),
//                               onPressed: () {
//                                 Navigator.pop(context, false);
//                               },
//                             ),
//                           if (choiceFalse != null) const Spacer(),
//                         ],
//                       ),
//                       const Spacer(),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: -22,
//                   left: 0,
//                   right: 0,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     radius: 24,
//                     child: icon == null
//                         ? Lottie.asset(
//                             'assets/lottie_files/e.json',
//                           )
//                         : Icon(
//                             icon,
//                             color: kPrimaryColor,
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ).then((value) {
//       if (value) {
//         onChoiceTrue!();
//       } else {
//         onChoiceFalse!();
//       }
//     });
//   }
// }
