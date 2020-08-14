import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_convention/constants/colors.dart';
import 'package:flutter_naming_convention/constants/font_family.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key key,
      this.onCallback,
      this.controller,
      this.iconPath = '',
      this.isIcon = true,
      this.obscureText = false,
      this.maxLines = 1,
      this.action,
      this.hint,
      this.focus})
      : super(key: key);
  final VoidCallback onCallback;
  final TextEditingController controller;
  final String iconPath;
  final bool isIcon;
  final bool obscureText;
  final int maxLines;
  final TextInputAction action;
  final String hint;
  final FocusNode focus;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: action,
      autofocus: false,
      maxLines: maxLines,
      focusNode: focus,
      obscureText: obscureText,
      onFieldSubmitted: (term) {
        onCallback();
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyInputText),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyInputText),
        ),
        labelStyle: FontFamily.greyInputStyle,
        suffixIcon: Visibility(
          child: Padding(
            padding: EdgeInsets.fromLTRB(6, 6, 0, 6),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.lightGreyColor),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Image.asset(iconPath),
              ),
            ),
          ),
          visible: isIcon,
        ),
      ),
      style: FontFamily.accentColorStyle,
    );
  }
}
