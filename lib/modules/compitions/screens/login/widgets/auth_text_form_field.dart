import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AuthTextFormField({super.key, 
    required this.hintText,
     this.onSaved,
    required this.onFieldSubmitted,
    this.focusNode,
    this.icon = Icons.person_outline,
    this.obscureText = false,
    this.validator,  
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white,),
      decoration: InputDecoration(

        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white38,),
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(color: Colors.red) ,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white38,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      obscureText: obscureText,
      validator: validator,
  
    );
  }
}


