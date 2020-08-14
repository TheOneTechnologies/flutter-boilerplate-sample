import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_convention/constants/assets.dart';
import 'package:flutter_naming_convention/constants/strings.dart';
import 'package:flutter_naming_convention/data/network/api_call.dart';
import 'package:flutter_naming_convention/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_naming_convention/localization/app_translations.dart';
import 'package:flutter_naming_convention/utils/util.dart';
import 'package:flutter_naming_convention/widgets/custom_button_widget.dart';
import 'package:flutter_naming_convention/widgets/custom_text_form_field_widget.dart';
import 'package:flutter_naming_convention/widgets/custom_toolbar_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../router.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final FocusNode _passFocus = FocusNode();
  final FocusNode _userFocus = FocusNode();
  ProgressDialog pd;

  //Method for checking username and password validation

  bool validate() {
    if (_nameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: AppTranslations.of(context).text(Strings.strUserRequired));
      return false;
    }
    if (_passController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: AppTranslations.of(context).text(Strings.strPassRequired));
      return false;
    }
    return true;
  }
//  bool validate() {
//    if(FormValidate.validateUsername(_nameController.text) != null) {
//      return false;
//    }
//    if(FormValidate.validatePassword(_passController.text) != null){
//      return false;
//    }
//    return true;
//  }

  void loginApi() async {
    await APICall()
        .loginUser(_nameController.text.toString(),
            _passController.text.toString(), 1, true)
        .then((res) => {
            Timer(Duration(seconds: 1), (){pd.hide();}),
              if (res.getException == null)
                {
                  //store data into sharedPref

                  SharedPreferenceHelper.storeBoolPrefData(
                      Strings.strIsLogin, true),
                  SharedPreferenceHelper.storeStringPrefData(
                      Strings.strLoginUser, res.data.toString()),
                  SharedPreferenceHelper.storeStringPrefData(
                      Strings.strAccessToken, res.data.access_token),
                 // Navigator.pop(context),
                  Navigator.pushReplacementNamed(context, Router.dashboardRoute)
                }
              else
                {
                  //display error msg
                  Util.displaySnackBar(_scaffoldKey,res.getException.getErrorMessage()),
                }
            });
  }

  Widget _showLoginButton() {
    return CustomButton(
        key: Key(Strings.strLoginKey),
        title: AppTranslations.of(context).text(Strings.strTxtLoginButton),
        width: 0.5,
        onCallback: () {
          //click listener for login button click
          if (validate()) {
            Util.checkInternetConnection().then((status) {
              if (status) {
                Util.hideKeyboard(context);
                pd.show();
                loginApi();
              } else {
                Util.displaySnackBar(_scaffoldKey,AppTranslations.of(context).text(Strings.noInternetConnection));
              }
            });
          }
        });
  }

  Widget myView() {
    return Container(
      decoration: Util.commonBackground(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CustomToolbar(
              title: AppTranslations.of(context).text(Strings.strLoginTitle)),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      child: ClipOval(
                        child: Center(
                          child: Image.asset(Assets.appLogo),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 3,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CustomTextFormField(
                              key: Key(Strings.strEmailKey),
                              controller: _nameController,
                              action: TextInputAction.next,
                              focus: _userFocus,
                              iconPath: Assets.userIcon,
                              hint: AppTranslations.of(context)
                                  .text(Strings.strHintUsername),
                              onCallback: () {
                                _userFocus.unfocus();
                                FocusScope.of(context).requestFocus(_passFocus);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                              key: Key(Strings.strPassKey),
                              controller: _passController,
                              obscureText: true,
                              action: TextInputAction.done,
                              hint: AppTranslations.of(context)
                                  .text(Strings.strHintPassword),
                              focus: _passFocus,
                              iconPath: Assets.keyIcon,
                              onCallback: _passFocus.unfocus,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  _showLoginButton(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    pd = Util.showLoader(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: myView(),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
class FormValidate{
  // validation
  static Future<bool> validateUsername(String email) {
    if (email.isEmpty) {
      return
        Fluttertoast.showToast(msg: Strings.strUserRequired);
    }
    return null;
  }

  static  Future<bool>  validatePassword(String password) {
    if (password.isEmpty) {
      return Fluttertoast.showToast(msg: Strings.strPassRequired);
    }
    return null;
  }
}

