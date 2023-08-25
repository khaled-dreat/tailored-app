// // ignore_for_file: use_build_context_synchronously

// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';


// import '../../../core/constants/constants.dart';
// import '../../../core/constants/size_config.dart';
// import '../../../core/widgets/custom_text_bottun.dart';
// import '../../../core/widgets/show_dialog.dart';
// import '../../../view_models/auth/auth_view_model.dart';
// import 'auth_text_form_field.dart';

// class LoginForm extends StatefulWidget {
//   const LoginForm({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
//   final AuthViewModel _auth = AuthViewModel();
//   final user = {
//     'email': '',
//     'password': '',
//   };
//   bool isObscuree = true;
//   final FocusNode emailFoucasNode = FocusNode();
//   final FocusNode passwordFoucasNode = FocusNode();
//   final _form = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//           right: MediaQuery.of(context).size.width * 0.28,
//           left: MediaQuery.of(context).size.width * 0.16),
//       child: Form(
//         key: _form,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Spacer(),
//             _emailFeild(context),
//             setVerticalSpace(3),
//             _passwordField(),
//             _forgotPassword(),
//             setVerticalSpace(5),
//             _letsStartBotton(),
//             const Spacer(flex: 3),
//           ],
//         ),
//       ),
//     );
//   }

//   AuthTextFormField _passwordField() {
//     return AuthTextFormField(
//       onFieldSubmitted: (_) {},
//       hintText: 'Password',
//       obscureText: isObscuree,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return kPassNullError;
//         } else if (value.length < 8) {
//           return kShortPassError;
//         } else {
//           return null;
//         }
//       },
//       onSaved: (value) {
//         user['password'] = value!.trim();

//       },

//       focusNode: passwordFoucasNode,
//       suffixIcon: isObscuree
//           ? GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isObscuree = !isObscuree;
//                 });
//               },
//               child: Image.asset(
//                 iconName('eye-crossed'),
//                 scale: 28,
//                 color: Colors.white38,
//               ))
//           : IconButton(
//               onPressed: () {
//                 setState(() {
//                   isObscuree = !isObscuree;
//                 });
//               },
//               icon: const Icon(Icons.remove_red_eye)),
//     );
//   }

//   AuthTextFormField _emailFeild(BuildContext context) {
//     return AuthTextFormField(
//       hintText: 'Email',
//       validator: (value) {
//         if (value!.isEmpty) {
//           return kEmailNullError;
//         } else if (!emailValidatorRegExp.hasMatch(value)) {
//           return kInvalidEmailError;
//         } else {
//           return null;
//         }
//       },
//       onSaved: (value) {
//         user['email'] = value!.trim();
//       },
//       onFieldSubmitted: (value) {
//         FocusScope.of(context).requestFocus(passwordFoucasNode);
//       },
//       focusNode: emailFoucasNode,
//     );
//   }

//   Align _letsStartBotton() {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: CustomTextButton(
//         onPressed: () async {
//           _form.currentState?.save();
//           try {
//             await _auth.signInWithEmailAndPassword(
//                 user['email']!, user['password']!);
//             Navigator.pushReplacementNamed(context, Routes.home);
//           } on FirebaseAuthException catch (e) {
//             ShowDialog.showMyDialog(context,
//                 title: 'Error!',
//                 discription: e.code == 'user-not-found'
//                     ? 'No user found for that email.'
//                     : 'Wrong password provided for that user.',
//                 choiceTrue: 'Got it',
//                 onChoiceTrue: () {},
//                 );
//             log('$e');
//           }
//         },
//         text: "Let's Start",
//         color: Colors.white38,
//         textColor: Colors.grey.shade300,
//         width: double.infinity,
//       ),
//     );
//   }

//   Align _forgotPassword() {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: TextButton(
//         onPressed: () {},
//         child: const Text(
//           "Forgot Password?",
//           style: TextStyle(color: Colors.white30),
//         ),
//       ),
//     );
//   }
// }
