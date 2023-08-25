import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailored/modules/chat/screen/chat_pages.dart';
import 'package:tailored/modules/home/screen/home.dart';
import 'package:tailored/modules/profile/screen/account.dart';
import 'package:tailored/utilities/color_manager.dart';

class Bottom_nav_bar extends StatefulWidget {
  const Bottom_nav_bar({Key? key}) : super(key: key);

  @override
  State<Bottom_nav_bar> createState() => _Bottom_nav_barState();
}

class _Bottom_nav_barState extends State<Bottom_nav_bar> {
  TextEditingController fname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  PersistentTabController? _controller;
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.house_alt_fill),
        title: ("Home"),
        activeColorPrimary: ColorManager.darkPrimary,
        inactiveColorPrimary: ColorManager.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chat_bubble_2_fill),
        title: ("Chat"),
        activeColorPrimary: ColorManager.darkPrimary,
        inactiveColorPrimary: ColorManager.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_fill),
        title: ("Settings"),
        activeColorPrimary: ColorManager.darkPrimary,
        inactiveColorPrimary: ColorManager.grey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      const Home(),
      const ChatList(),
      ProfilePage(fname,phone,email),
    ];
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) {
      fname.text = pref.getString('name')!;
      phone.text = pref.getString('phone')!;
      email.text = pref.getString('email')!;
    });
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: ColorManager.primary, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: ColorManager.white,
      ),
      margin: const EdgeInsets.all(16),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style13, // Choose the nav bar style with this property.
    );
  }




}
