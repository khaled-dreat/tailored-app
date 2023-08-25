import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function onPressed;
  final double height;
  final double width;
  final double borderRadius;
  final double fontSize;
  final Color color;


  const CustomTextButton({super.key, 
    required this.text,
    required this.onPressed,
     this.textColor=Colors.white,
     this.width=50,
     this.height=50,
     this.color=Colors.black,
     this.borderRadius=10,
      this.fontSize=12,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
       // color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed:  () => onPressed(),
        child: CustomText(
          text: text,
          fontSize: fontSize,
          alignment: Alignment.center,
          color: textColor,
        ),
      ),
    );
  }
}
