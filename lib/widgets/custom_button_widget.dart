import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_convention/constants/assets.dart';
import 'package:flutter_naming_convention/constants/colors.dart';
import 'package:flutter_naming_convention/constants/font_family.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key key,
      this.title,
      this.iconPath = '',
      this.onCallback,
      this.isIcon = true,
      this.width = 0.4,
    //    this.key_,
      this.height = 50.0})
      : super(key: key);
  final VoidCallback onCallback;
  final String title;
  final String iconPath;
  final bool isIcon;
  final double width;
  final double height;
//  final Key key_;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: height,
      child: RaisedButton(
      //  key: key_,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: AppColors.primaryColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: FontFamily.whiteBoldTextStyle,
              ),
            ),
            Visibility(
              visible: isIcon,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Assets.loginButtonIcon,
                    width: 22,
                    height: 22,
                  )
                ],
              ),
            )
          ],
        ),
        onPressed: onCallback,
      ),
    );
  }
}
