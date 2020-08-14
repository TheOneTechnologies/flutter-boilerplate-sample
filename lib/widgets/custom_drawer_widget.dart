import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_convention/constants/assets.dart';
import 'package:flutter_naming_convention/constants/colors.dart';
import 'package:flutter_naming_convention/constants/font_family.dart';
import 'package:flutter_naming_convention/constants/strings.dart';
import 'package:flutter_naming_convention/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_naming_convention/localization/app_translations.dart';
import 'package:share/share.dart';

import '../router.dart';
import 'custom_alert_dialog_widget.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawer createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> {
  void showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            title: AppTranslations.of(context).text(Strings.strAppName),
            button1: AppTranslations.of(context).text(Strings.strYes),
            button2: AppTranslations.of(context).text(Strings.strNo),
            description: AppTranslations.of(context)
                .text(Strings.strAreYouSureWantToLogout),
            callback1: () {
              Navigator.of(context).pop();
              SharedPreferenceHelper.clearPrefData();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Router.loginRoute, (Route<dynamic> route) => false);
            },
            callback2: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      child: Drawer(
        child: Container(
          color: AppColors.primaryColor,
          child: Column(
            children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width * 0.88,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.blurBg), fit: BoxFit.cover)),
                child: DrawerHeader(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.lightWhiteColor,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          child: CircleAvatar(
                            radius: 36,
                            backgroundImage: AssetImage(Assets.user),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            //  Navigator.pushNamed(context, Router.myProfile);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'UserName',
                                style: FontFamily.whiteBigTextStyle,
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    InkWell(
                      child: Image.asset(
                        Assets.arrow,
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )),
              ),
              Expanded(
                child: Container(
                  color: AppColors.primaryColor,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: ListView(children: [
                      CustomListTile(
                          Assets.dashboard,
                          AppTranslations.of(context)
                              .text(Strings.strDashboard), () {
                        Navigator.of(context).pop();
                      }),
                      CustomListTile(Assets.like,
                          AppTranslations.of(context).text(Strings.strRate),
                          () {
                        Navigator.of(context).pop();
                      }),
                      CustomListTile(Assets.settings,
                          AppTranslations.of(context).text(Strings.strSettings),
                          () {
                        Navigator.of(context).pop();
                      }),
                      CustomListTile(Assets.shareIcon,
                          AppTranslations.of(context).text(Strings.strShare),
                          () {
                        Navigator.of(context).pop();
                        //to share text content with installed apps
                        Share.share(
                            'Check out my website https://www.google.com');
                        //Share.share('Check out my website https://www.google.com', subject: 'Look what I made!'); //with subject
                      }),
                      CustomListTile(Assets.logout,
                          AppTranslations.of(context).text(Strings.strLogout),
                          () {
                        Navigator.of(context).pop();
                        showLogoutDialog(context);
                      }),
                    ]),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '${AppTranslations.of(context).text(Strings.strVersion)} : 1.0',
                    style: FontFamily.lightWhiteMediumTextStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: onTap,
          child: Container(
              color: Colors.transparent,
              child: ListTile(
                title: Text(text, style: FontFamily.whiteMediumTextStyle),
                leading: Image.asset(
                  icon,
                  width: 24,
                  height: 24,
                ),
              ))),
    );
  }
}
