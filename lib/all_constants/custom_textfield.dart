import 'package:tailored/utilities/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final double? width;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final Function? onSaved;
  final Function? onChange;
  final TextDirection? textDirection;
  final Widget? suffixIcon;
  final bool? isPassword;
  final bool? istitle;
  final bool? isEmail;
  final List<TextInputFormatter>? inputFormatters;

  final bool? enabled;
  final bool? isPhone;
  final Widget? prefix;
  final TextInputType? keyboard_type;
  final String? intialLabel;
  final GestureTapCallback? press;
  final FocusNode? focus;
  final TextEditingController? controller;
  final TextAlign? textAlign;

  MyTextFormField(
      {this.hintText,
      this.labelText,
      this.errorText,
      this.validator,
      this.width,
      this.onSaved,
      this.onChange,
      this.textDirection,
      this.suffixIcon,
      this.isPassword,
      this.istitle,
      this.isEmail,
      this.inputFormatters,
      this.enabled,
      this.isPhone,
      this.prefix,
      this.keyboard_type,
      this.intialLabel,
      this.press,
      this.focus,
      this.controller,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          istitle!
              ? Container()
              : Text(
                  labelText ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
          errorText == null
              ? Container()
              : Text(
                  errorText ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
          istitle!
              ? Container()
              : const SizedBox(
                  height: 4,
                ),
          TextFormField(
            textAlign: textAlign ?? TextAlign.start,
            controller: controller,
            focusNode: focus,
            inputFormatters: inputFormatters ??
                [
                  LengthLimitingTextInputFormatter(254),
                ],
            //autofocus: true,
            onTap: press,
            initialValue: intialLabel,
            decoration: InputDecoration(
              fillColor: Colors.white,
              prefixIcon: prefix,
              hintText: hintText,
              hintStyle: TextStyle(color: ColorManager.grey),
              contentPadding: const EdgeInsets.all(10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.black12,
                  width: 1.0,
                ),
              ),
              filled: true,
              suffixIcon: this.suffixIcon,
            ),
            obscureText: isPassword! ? true : false,
              validator: validator,
            // autovalidate: true,

            textDirection: textDirection,
            //  onSaved: onSaved!,
            enabled: enabled,
            //   onChanged:onChange ,
            keyboardType: keyboard_type ?? TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}
