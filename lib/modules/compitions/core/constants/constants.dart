import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF703EFF);


const kPrimaryLightColor = Color(0xFFFAFAFA);
final kSecondaryLightColor =  Colors.grey.shade300;

final kContentColorLightTheme = Colors.grey.shade800;


const kSecondaryDarkColor =  Color(0xFF1B1A1D);
const kPrimaryyDarkColor = Color(0xFF2B2D2E);

const kPrimaryDarkColor =  Color(0xFFFAFAFA); 
const kContentColorDarkTheme =  Color.fromARGB(255, 16, 15, 14);


String imageName(imageName){
return 'assets/images/$imageName.png';
}

String iconName(iconName){
return 'assets/icons/$iconName.png';
}



const kOutLineDarkColor = Color(0xFF272C30);
//final kSecondaryDarkColor = Color(0x1B2F528F); secondary

const kErrorColor = Color(0xFF757575);

const primaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
final kSecondaryColor = Colors.grey.shade300;
const textColor = Color(0xFF757575);

const animationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  // fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);
const defaultpadding = 15.0;
const defaultmargin = 8.0;
const Color login_bg = Color(0xFF00C470);
const Color signup_bg = Color(0xFF000A54);

const double defpaultPadding = 16.0;
// const Duration defaultDuration = Duration(milliseconds: 300);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

// final otpInputDecoration = InputDecoration(
//   contentPadding:
//       EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
//   border: outlineInputBorder(),
//   focusedBorder: outlineInputBorder(),
//   enabledBorder: outlineInputBorder(),
// );

// OutlineInputBorder outlineInputBorder() {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
//     borderSide:const  BorderSide(color: textColor),
//   );
// }

const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);

enum Pages {
  deliveryTime,
  addAddress,
  summary,
}
