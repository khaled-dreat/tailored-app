// import 'package:flutter/material.dart';

// import '../constants/constants.dart';
// import '../constants/size_config.dart';
// import 'custom_text.dart';

// class UserCard extends StatelessWidget {

//   final String name;
//   final String userId;
//   final String userImageUrl;

//   const UserCard(
//       {super.key,
//       required this.name,
//       required this.userImageUrl,
//       required this.userId});

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     var boxDecoration = BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       color: getColorTheme(),
//     );

//     return Container(
//       decoration: boxDecoration,
//       padding: const EdgeInsets.all(defaultpadding),
//       margin: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ProfilePictuerOnline(
//               ownerId: userId,
//               radius1: 19,
//               radius2: 12,
//               imageUrl: userImageUrl),
//           setHorizentalSpace(5),
//           _buildUserNameSection(),
//           const Spacer(),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserNameSection() {
//     return CustomText(
//       text: name,
//       fontSize: 14,
//       fontWeight: FontWeight.bold,
//     );
//   }
// }
