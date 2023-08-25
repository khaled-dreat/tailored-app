import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailored/all_widgets/result_overlay.dart';
import 'package:tailored/utilities/color_manager.dart';
import 'package:tailored/all_widgets/display_image_widget.dart';
import 'package:tailored/local/LanguageTranslated.dart';
import 'package:tailored/model/Profile.dart';
import 'package:tailored/model/activity.dart';
import 'package:tailored/model/user.dart';
import 'package:tailored/utilities/fun_app/navigator.dart';
import 'package:tailored/providers/provider_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailored/utilities/screen_size.dart';
import 'package:tailored/service/api.dart';
import 'package:tailored/modules/splash/screen/splash.dart';
import '../../../all_constants/custom_textfield.dart';
import '../../../model/user.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  ProfilePage(this.fname, this.phone, this.email);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool enabled = false;
  final List<Activity> activities = [];

  Profile? user;

  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) {
      widget.fname.text = pref.getString('name')!;
      widget.phone.text = pref.getString('phone')!;
      widget.email.text = pref.getString('email')!;
    });
    API(context).get('accounts/mine/activity/', Token: true).then((value) {
      var data = value['data'];
      data.forEach((element) {
        setState(() {
          activities.add(Activity.fromJson(element));
        });
      });
    });
    API(context).get('accounts/mine/', Token: true).then((value) {
      print(" value : $value");
      var data = value['data'];

      setState(() {
        user = Profile.fromJson(data);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 10,
              ),
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        ' حسابي',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.primary,
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {},
                            child: DisplayImage(
                              imagePath: "${themeColor.user.avatar}",
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
// Pick an image.
                                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              },
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Ramallah'),
                            Text(widget.fname.text),
                            Text(widget.email.text),
                            InkWell(
                              onTap: () {
                                SharedPreferences.getInstance().then((value) => value.clear());
                                API(context).post("auth/logout", {}).then((value) {});
                                Phoenix.rebirth(context);
                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
                                //     ModalRoute.withName('/')
                                // );
                              },
                              child: Text("${getTransrlate(context, 'logout')}", style: TextStyle(color: ColorManager.darkGrey, fontSize: 20)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Last Online: 7h ago'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Icon(Icons.star_border),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Friends: ${user?.friends?.length}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TabBar(
                tabs: [
                  Tab(text: "Profile"),
                  Tab(text: "Activity"),
                  Tab(icon: Icon(Icons.settings)),
                ],
                labelColor: Colors.black,
                // isScrollable: true,
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Apparently, this user prefers to keep an air of mystery about them.'),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'friends :- ',
                                style: TextStyle(color: ColorManager.primary, fontSize: 20),
                              ),
                            ),
                            ListView.builder(
                                itemCount: user?.friends?.length ?? 0,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final friend = (user?.friends ?? [])![index];

                                  return ListTile(
                                    title: Text("${friend?.firstName} ${friend?.lastName}"),
                                    subtitle: Text(
                                      "${friend?.relationType}",
                                      style: TextStyle(color: ColorManager.primary),
                                    ),
                                    leading: CachedNetworkImage(
                                      imageUrl: "${friend?.avatar}",
                                      width: 50,
                                      height: 50,
                                      errorWidget: (context, url, error) => Icon(Icons.person),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: activities
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: ScreenUtil.getWidth(context) / 1.2,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${e.type}"),
                                        Text(
                                          "${e.timestamp}",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          !enabled
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        enabled = true;
                                      });
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          ' تعديل الحساب',
                                          style: TextStyle(decoration: TextDecoration.underline),
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: ColorManager.primary,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: ColorManager.primary,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            API(context).patch("accounts/mine/", {"first_name": "${widget.fname}", "last_name": "${widget.lname}", "phone_number": "${widget.phone}"}).then((value) {
                                              if (value['code'] == 200) {
                                                setState(() {
                                                  enabled = false;
                                                });
                                              } else {
                                                showDialog(context: context, builder: (_) => ResultOverlay("\n عذرا تاكد من صحه بياناتك\n $value  ", cash: false));
                                              }

                                              print(value);
                                            });
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                ' حفظ الحساب',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.save,
                                                color: ColorManager.white,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                MyTextFormField(
                                  controller: widget.fname,
                                  istitle: false,
                                  enabled: enabled,
                                  isEmail: false,
                                  isPassword: false,
                                  isPhone: false,
                                  labelText: 'اسم الاول',
                                  hintText: "ادخل الاول",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {},
                                ),
                                MyTextFormField(
                                  controller: widget.lname,
                                  istitle: false,
                                  enabled: enabled,
                                  isEmail: false,
                                  isPassword: false,
                                  isPhone: false,
                                  labelText: 'اسم العائله',
                                  hintText: "ادخل اسم العائله",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {},
                                ),
                                MyTextFormField(
                                  controller: widget.phone,
                                  keyboard_type: TextInputType.phone,
                                  istitle: false,
                                  enabled: enabled,
                                  isEmail: false,
                                  isPassword: false,
                                  isPhone: true,
                                  labelText: 'رقم الهاتف',
                                  hintText: "رقم الهاتف",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {},
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
