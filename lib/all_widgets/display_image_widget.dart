import 'dart:io';

import 'package:tailored/utilities/color_manager.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  // Constructor
  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = ColorManager.primary;

    return Center(
        child: Stack(children: [
      buildImage(color),
      Positioned(
        child: buildEditIcon(color),
        right: 2,
        top: 5,
      )
    ]));
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(image:DecorationImage(image:  image as ImageProvider), color: color,)
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => IconButton(
    icon: Icon(
      Icons.mode_edit,
      color: Colors.white,
      size: 20,
    ),onPressed: onPressed,
  );

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
