import 'package:flutter/cupertino.dart';
import 'package:flutter_naming_convention/constants/colors.dart';

class FontFamily{
  FontFamily._();

  static const robotoMedium = 'Roboto Medium';
  static const robotoBold = 'Roboto Bold';
  static const pantonBlackCaps = 'Panton BlackCaps';
  static const robotoLight = 'Roboto Light';

  static const TextStyle greyInputStyle = TextStyle(
      color: AppColors.greyInputText,
      fontFamily: 'Roboto Light',
      fontSize: 15.0);

  static const TextStyle lightWhiteStyle = TextStyle(
      color: AppColors.lightWhiteColor,
      fontFamily: FontFamily.robotoLight,
      decoration: TextDecoration.none,
      fontSize: 14);

  static const TextStyle accentColorStyle = TextStyle(
      fontFamily: FontFamily.robotoMedium,
      color: AppColors.accentColor,
      fontSize: 16);

  static const TextStyle pantonBlackCapsStyle =TextStyle(
      color: AppColors.white,
      fontSize: 15,
      fontFamily: FontFamily.pantonBlackCaps);

  static const TextStyle whiteBoldTextStyle = TextStyle(
      color: AppColors.white,
      fontFamily: FontFamily.robotoBold);

  static const TextStyle whiteMediumTextStyle = TextStyle(
      color: AppColors.white,
      fontFamily: FontFamily.robotoMedium,
      fontSize: 16);

  static const TextStyle whiteBigTextStyle =  TextStyle(
      color: AppColors.white,
      fontFamily: FontFamily.robotoMedium,
      fontSize: 20);

  static const TextStyle lightWhiteMediumTextStyle = TextStyle(
      fontFamily: FontFamily.robotoMedium,
      color: AppColors.lightWhiteColor,
      fontSize: 16);

}