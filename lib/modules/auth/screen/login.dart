import 'package:tailored/all_widgets/result_overlay.dart';
import 'package:tailored/all_constants/bottom_nav_bar.dart';
import 'package:tailored/utilities/color_manager.dart';
import 'package:tailored/all_constants/custom_textfield.dart';
import 'package:tailored/utilities/font_manager.dart';
import 'package:tailored/modules/home/screen/home.dart';
import 'package:tailored/model/user.dart';
import 'package:tailored/utilities/fun_app/navigator.dart';
import 'package:tailored/providers/provider_notifier.dart';
import 'package:tailored/providers/auth_provider.dart';
import 'package:tailored/modules/auth/screen/register.dart';
import 'package:tailored/utilities/screen_size.dart';
import 'package:tailored/service/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  TextEditingController password = TextEditingController();
  TextEditingController phone =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'مرحبا بك',
                style: TextStyle(color: ColorManager.darkGrey, fontSize: 25),
              ),
              Text('اختر معلمك المفضل وابدأ التعلم',
                  style: TextStyle(color: ColorManager.grey)),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextFormField(
                      controller: phone,
                      istitle: false,
                      isEmail: false,
                      isPassword: false,
                      isPhone: false,
                      labelText: 'البريد الالكترونى',
                      hintText: "البريد الالكترونى",
                      validator: ( value) {
                        if (value!.isEmpty) {
                          return 'required';
                        }
                        _formKey.currentState?.save();
                        return null;
                      },
                      onSaved: (String value) {},
                    ),
                    MyTextFormField(
                      controller: password,
                      istitle: false,
                      isEmail: false,
                      isPassword: passwordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black26,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      isPhone: false,
                      labelText: 'كلمه السر',
                      hintText: "أدخل كلمة المرور",
                      validator: ( value) {
                        if (value!.isEmpty) {
                          return 'required';
                        }
                        _formKey.currentState?.save();
                        return null;
                      },
                      onSaved: (String value) {},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          API(context).post('auth/login/', {
                            'email': phone.text,
                            'password': password.text,
                          },token: true).then((value) async {
                            if (value['code'] == 200) {
                              var data=value['data'];
                              themeColor.setUser(User.fromJson(data));
                              SharedPreferences.getInstance().then((pref) {
                                pref.setString('token', data['token']);
                                pref.setString('name', "${data['first_name']} ${data['last_name']}");
                                pref.setString('email', data['email']);
                                pref.setString('phone', data['phone_number'] ?? '');
                                pref.setInt('id', data['id']);
                              });
                        authProvider.handleSignIn(User.fromJson(data));

                              showDialog(
                                  context: context,
                                  builder: (_) => ResultOverlay(
                                        " مرحبا ${data['first_name']} ",
                                        cash: false,
                                      )).whenComplete(
                                  () => Nav.route(context, Bottom_nav_bar()));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => ResultOverlay(
                                      "عذرا تاكد من صحه بياناتك ",
                                      cash: false));
                            }
                          });
                        },
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 1.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: ColorManager.darkGrey),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 60),
                            child: Center(
                                child: Text(
                              "التالي",
                              style: TextStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s20),
                            )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ليس لديك حساب؟ ',
                            style: TextStyle(
                                color: ColorManager.black, fontSize: 20)),
                        InkWell(
                          onTap: () {
                            Nav.route(context, Register());
                          },
                          child: Text('سجل الان',
                              style: TextStyle(
                                  color: ColorManager.darkGrey, fontSize: 20)),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: ScreenUtil.getWidth(context) / 5,
                        ),
                      ),
                    ),
                    Center(
                      child: Text('منصـة مشكاة التعليميــة',
                          style: TextStyle(
                              color: ColorManager.black, fontSize: 20)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
