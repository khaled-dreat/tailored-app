// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class CustomButton extends StatelessWidget {
   CustomButton({

    required this.text,
    required this.onTap,
  }) ;
  void Function()? onTap;
  final String text;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
        decoration: BoxDecoration(
          gradient: kPrimaryGradient,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              !.copyWith(color: Colors.black),
        ),
      ),
    );
  }
  }
