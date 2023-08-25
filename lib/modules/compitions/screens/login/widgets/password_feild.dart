
  import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
class PasswordFormFeild extends StatefulWidget {
  const PasswordFormFeild({super.key});

  @override
  State<PasswordFormFeild> createState() => _PasswordFormFeildState();
}

class _PasswordFormFeildState extends State<PasswordFormFeild> {
  bool isObscuree = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                obscureText: isObscuree,
                decoration: 
              InputDecoration(
                hintText: "Password",
                suffixIcon: isObscuree
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                          isObscuree = !isObscuree;
                            
                          });
                        },
                        child: Image.asset(
                          iconName('eye-crossed'),
                          scale: 25,
                          color:Colors.white38,
                        ))
                    : IconButton(onPressed: (){ setState(() {
                          isObscuree = !isObscuree;
                          });},icon:Icon(Icons.remove_red_eye)),
              )
    );
  }
}
