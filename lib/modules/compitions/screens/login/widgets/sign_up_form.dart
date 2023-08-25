// // ignore_for_file: use_build_context_synchronously

// import 'dart:developer';

// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import '../../../core/constants/constants.dart';
// import '../../../core/widgets/custom_text_bottun.dart';
// import '../../../view_models/auth/auth_view_model.dart';


// class SignUpForm extends StatefulWidget {
//   const SignUpForm({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<SignUpForm> createState() => _SignUpFormState();
// }

// class _SignUpFormState extends State<SignUpForm> {
//   final user = {
//     'name': '',
//     'email': '',
//     'password': '',
//   };
//   final AuthViewModel _auth = AuthViewModel();
//   final FirebaseAuthService _authCredintail = FirebaseAuthService();

//   bool isObscuree = true;
//   final FocusNode userNameFoucsNode = FocusNode();
//   final FocusNode emailFoucasNode = FocusNode();
//   final FocusNode passwordFoucasNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   bool valueOfRemmebrMe = false;
//   void _saveForm() {
//     final isvalid = _form.currentState!.validate();
//     if (!isvalid) {
//       return;
//     }
//     _form.currentState?.save();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: MediaQuery.of(context).size.width * 0.16,
//         right: MediaQuery.of(context).size.width * 0.15,
//       ),
//       child: Form(
//         key: _form,
//         child: Column(
//           children: [
//             const Spacer(),
//             _userNameField(context),
//             setVerticalSpace(2),
//             _emailField(context),
//             setVerticalSpace(2),
//             _passwordField(),
//             setVerticalSpace(2),
//             _registerBotton(),
//             const Spacer(flex: 3)
//           ],
//         ),
//       ),
//     );
//   }

//   Align _registerBotton() {
//     final userViewModel = Provider.of<UserViewModel>(context, listen: false);
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: CustomTextButton(
//         onPressed: () async {
//           final isvalid = _form.currentState!.validate();
//           if (!isvalid) {
//             return;
//           } else {
//             _form.currentState?.save();
//             try {
//               await _auth.creatNewAccount(user['email']!, user['password']!);
//               await userViewModel.createUserInfo(
//                 user['email']!,
//                 user['name']!,
//               );
//               NavigatorService.pushFadeTransition(context, const HomeScreen(),);
          
//             } catch (e) {
//               log('The error when create new user is:$e');
//             }
//           }
//         },
//         text: "Register",
//         textColor: kPrimaryColor,
//         color: Colors.white,
//         width: setWidth(32),
//         height: setHeight(5),
//       ),
//     );
//   }

//   AuthTextFormField _passwordField() {
//     return AuthTextFormField(
//         focusNode: passwordFoucasNode,
//         hintText: "Password",
//         obscureText: isObscuree,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return kPassNullError;
//           } else if (value.length < 8) {
//             return kShortPassError;
//           } else {
//             return null;
//           }
//         },
//         onSaved: (value) {
//           user['password'] = value!;
//         },
//         onFieldSubmitted: (value) {
//           _saveForm();

//           _auth.creatNewAccount(user['email']!, user['password']!);
//         },
//         suffixIcon: isObscuree
//             ? GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     isObscuree = !isObscuree;
//                   });
//                 },
//                 child: Image.asset(
//                   iconName('eye-crossed'),
//                   scale: 28,
//                   color: Colors.white38,
//                 ))
//             : IconButton(
//                 onPressed: () {
//                   setState(() {
//                     isObscuree = !isObscuree;
//                   });
//                 },
//                 icon: const Icon(Icons.remove_red_eye)));
//   }

//   AuthTextFormField _emailField(BuildContext context) {
//     return AuthTextFormField(
//       onSaved: (value) {
//         user['email'] = value!;
//       },
//       focusNode: emailFoucasNode,
//       hintText: 'email@example.com',
//       onFieldSubmitted: (value) {
//         FocusScope.of(context).requestFocus(passwordFoucasNode);
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           return kEmailNullError;
//         } else if (!emailValidatorRegExp.hasMatch(value)) {
//           return kInvalidEmailError;
//         } else {
//           return null;
//         }
//       },
//     );
//   }

//   AuthTextFormField _userNameField(BuildContext context) {
//     return AuthTextFormField(
//       hintText: "user_name",
//       onSaved: (value) {
//         user['name'] = value!;
//       },
//       onFieldSubmitted: (value) {
//         FocusScope.of(context).requestFocus(emailFoucasNode);
//       },
//     );
//   }
// }
