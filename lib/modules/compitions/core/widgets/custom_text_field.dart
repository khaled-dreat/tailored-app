import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  final String text;
  final Color color;
  //final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Function onFieldSubmitted;
  final Function onSaved;


   CustomTextFormField({super.key, 
      required this.text,
       this.focusNode,
      required this.onFieldSubmitted,
      required this.onSaved,
      //required this.controller,
      this.textInputAction=TextInputAction.none,
      this.keyboardType=TextInputType.emailAddress,
      this.color=Colors.grey,
      


});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:  InputDecoration(
        hintText: text,
        //'example1@gmail.com',
        hintStyle:  TextStyle(
          color: color,
        ),
      ),
      focusNode: focusNode,
   //   controller: controller,
      textInputAction: textInputAction,
      keyboardType:keyboardType ,
      onFieldSubmitted: onFieldSubmitted(),
      onSaved: (newValue) {
         onSaved(value){
          value=newValue;
         }
      },
    );
  }
}