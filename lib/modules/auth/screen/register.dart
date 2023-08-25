import 'package:flutter/material.dart';
import 'package:tailored/all_constants/custom_textfield.dart';
import 'package:tailored/all_widgets/result_overlay.dart';
import 'package:tailored/local/LanguageTranslated.dart';
import 'package:tailored/modules/auth/screen/login.dart';
import 'package:tailored/service/api.dart';
import 'package:tailored/utilities/color_manager.dart';
import 'package:tailored/utilities/font_manager.dart';
import 'package:tailored/utilities/fun_app/navigator.dart';
import 'package:tailored/utilities/screen_size.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'قم بإنشاء',
                        style: TextStyle(
                            color: ColorManager.darkGrey, fontSize: 25),
                      ),
                      Text('حسابك الآن',
                          style: TextStyle(
                              color: ColorManager.darkGrey, fontSize: 25)),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 50,
                  )
                ],
              ),
              Text(
                  'قم بالتسجيل لمواصلة استكشاف المعلمين الرائعين وجميع الدورات التي تحتاجها',
                  style: TextStyle(color: ColorManager.grey)),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextFormField(
                      istitle: false,
                      isEmail: false,
                      isPassword: false,
                      controller: fname,
                      isPhone: false,
                      labelText: 'الاسم الأول',
                      hintText: "ادخل الاسم الأول",
                      validator: ( value) {
                        print("object");
                        if (value!.isEmpty) {
                          return getTransrlate(context, 'requiredempty');
                        }
                        _formKey.currentState?.save();
                        return null;
                      },
                      onSaved: (String value) {},
                    ),
                    MyTextFormField(
                      istitle: false,
                      isEmail: false,
                      isPassword: false,
                      controller: lname,
                      isPhone: false,
                      labelText: 'الاسم الثانى',
                      hintText: "ادخل الاسم الثانى",
                      validator: ( value) {
                        if (value!.isEmpty) {
                          return getTransrlate(context, 'requiredempty');
                        }
                        _formKey.currentState?.save();
                        return null;
                      },
                      onSaved: (String value) {},
                    ),
                    MyTextFormField(
                      istitle: false,
                      isEmail: true,
                      isPassword: false,
                      controller: email,
                      isPhone: false,
                      labelText: 'البريد الالكترونى',
                      hintText: "البريد الالكترونى",
                      validator: ( value) {
                        if (value!.isEmpty) {
                          return getTransrlate(context, 'requiredempty');
                        }
                        _formKey.currentState?.save();
                        return null;
                      },
                      onSaved: (String value) {},
                    ),
                    MyTextFormField(
                      istitle: false,
                      isEmail: false,
                      isPassword: true,
                      controller: password,
                      isPhone: false,
                      labelText: 'كلمة المرور',
                      hintText: "ادخل كلمة المرور",
                      validator: ( value) {
                        if (value!.isEmpty) {
                          return getTransrlate(context, 'requiredempty');
                        } else if (value.length < 8) {
                          return getTransrlate(context, 'PasswordShorter');
                        } else if (!RegExp(r'^(?=.{8,32}$)(?=.*[ -\/:-@\[-\`{-~]{1,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).*$').hasMatch(value)) {
                          return "${getTransrlate(context, 'password_complex')}";
                        }
                        _formKey.currentState?.save();

                        return null;
                      },
                      onSaved: (String value) {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            API(context).post('auth/register/', {
                              'first_name': fname.text,
                              'last_name': lname.text,
                              'email': email.text,
                              'new_password': password.text,
                            },token: true).then((value) {
                              
                              print(value);
                              print('22222222222222');
                              if (value['code'] == 201) {
                                Nav.routeReplacement(context, const LoginScreen());
                              var  snackBar = const SnackBar(
                                  content: Center(
                                      child: Text(
                                        'تم التسجيل من فضلك قم تسجيل الدخول ',
                                        style: TextStyle(
                                          color: Colors.white,),
                                      )),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.symmetric(horizontal: 50,vertical: 50),

                                  backgroundColor:
                                  Colors.green,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => ResultOverlay(
                                        "\n عذرا تاكد من صحه بياناتك\n $value  ",
                                        cash: false));
                              }
                            });
                          }
                        },
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 1.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: ColorManager.darkGrey),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('هل لديك حساب؟ ',
                            style: TextStyle(
                                color: ColorManager.black, fontSize: 20)),
                        InkWell(
                          onTap: () {
                            Nav.route(context, const LoginScreen());
                          },
                          child: Text('تسجيل الدخول',
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
