import 'package:tailored/all_constants/bottom_nav_bar.dart';
import 'package:tailored/utilities/font_manager.dart';
import 'package:tailored/model/user.dart';
import 'package:tailored/providers/provider_notifier.dart';
import 'package:tailored/providers/auth_provider.dart';
import 'package:tailored/modules/auth/screen/register.dart';
import 'package:tailored/utilities/fun_app/navigator.dart';
import 'package:tailored/utilities/screen_size.dart';
import 'package:tailored/service/api.dart';
import 'package:flutter/material.dart';
import 'package:tailored/utilities/color_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showButton = false;

  @override
  void initState() {
    final themeColor = Provider.of<Provider_control>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    API(context).get('auth/status/').then((value) {
      print(value);
      if (value['code'] == 200) {
        var data = value['data'];

        themeColor.setUser(User.fromJson(data));
        authProvider.handleSignIn(User.fromJson(data));

        SharedPreferences.getInstance().then((pref) {
          pref.setString('name', "${data['first_name']} ${data['last_name']}");
          pref.setString('email', data['email']);
          pref.setString('phone', data['phone_number'] ?? '');
          pref.setInt('id', data['id']);
        });

        Nav.route(context, Bottom_nav_bar());
      } else {
        setState(() {
          showButton = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Image.asset(
              "assets/images/logo.png",
              height: ScreenUtil.getHeight(context) / 1.5,
              width: ScreenUtil.getWidth(context) / 1.5,
            ),
          ),
          showButton
              ? GestureDetector(
                  onTap: () {
                    Nav.route(context, Register());
                  },
                  child: Container(
                    width: ScreenUtil.getWidth(context) / 1.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: ColorManager.primary),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 60),
                      child: Center(
                          child: Text(
                        "أبدا الان",
                        style: TextStyle(
                            color: ColorManager.white, fontSize: FontSize.s20),
                      )),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
