import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naming_convention/constants/assets.dart';
import 'package:flutter_naming_convention/constants/colors.dart';
import 'package:flutter_naming_convention/constants/strings.dart';
import 'package:flutter_naming_convention/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_naming_convention/utils/util.dart';

import '../../router.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    //set statusBar color of app
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor));

    redirectToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: Util.commonBackground(),
        child: Center(
            child: Image.asset(
          Assets.appLogo,
          width: 150,
          height: 150,
        )),
      ),
    );
  }

  void checkIsLogin() async {
    bool isLogin =
        await SharedPreferenceHelper.getBoolPrefData(Strings.strIsLogin);

    if (isLogin) {
      //If isLogin true
      await Navigator.of(context).pushNamedAndRemoveUntil(
          Router.dashboardRoute, (Route<dynamic> route) => false);
    } else {
      await Navigator.of(context).pushNamedAndRemoveUntil(
          Router.loginRoute, (Route<dynamic> route) => false);
    }
  }

  void redirectToNextScreen() {
    Timer(Duration(seconds: 2), checkIsLogin);
  }
}
