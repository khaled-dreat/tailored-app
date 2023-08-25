import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Alignment alignment;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final double? heightBetweenLines;

  const CustomText({super.key, 
    required this.text,
    this.fontSize = 12,
    this.color = textColor,
    this.fontWeight = FontWeight.normal,
    this.alignment = Alignment.center,
    this.maxLines,
    this.textOverflow,
    this.heightBetweenLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: TextOverflow.clip,
        height: heightBetweenLines,
        fontFamily: 'Jet'
        
      ),
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: TextAlign.center,
    );
  }
}
