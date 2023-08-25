import 'package:tailored/utilities/color_manager.dart';
import 'package:tailored/utilities/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../local/LanguageTranslated.dart';

class ResultOverlay extends StatefulWidget {
  String? message;
  Widget? icon;
  bool cash = true;

  ResultOverlay(this.message, {this.icon, this.cash = true});

  @override
  State<StatefulWidget> createState() => ResultOverlayState();
}

class ResultOverlayState extends State<ResultOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller?.addListener(() {
      setState(() {});
    });

    controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
            width: ScreenUtil.getWidth(context) / 1.3,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: ScreenUtil.getWidth(context) / 2,
                  child: Text(
                    widget.message ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorManager.primary,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                widget.cash
                    ? InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            decoration: ShapeDecoration(
                                color: ColorManager.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            child: const Text(
                              "ادفع بفودافون كاش",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            decoration: ShapeDecoration(
                                color: ColorManager.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            child: const Text(
                              "اغلاق",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
