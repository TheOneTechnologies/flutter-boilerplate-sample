import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_convention/constants/assets.dart';
import 'package:flutter_naming_convention/constants/colors.dart';
import 'package:flutter_naming_convention/constants/strings.dart';
import 'package:flutter_naming_convention/localization/app_translations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Util {
  Util._();

  // check internet function
  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      await Fluttertoast.showToast(msg: Strings.noInternetConnection);
      return false;
    }
    return true;
  }

  static List<double> _stops = [0.0, 0.7];

  // common Background function
  static BoxDecoration commonBackground() {
    return BoxDecoration(
        color: AppColors.primaryColor,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryColor, AppColors.accentColor],
            stops: _stops),
        image: DecorationImage(
            image: AssetImage(Assets.background), fit: BoxFit.cover));
  }

  // hide keyboard from screen
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  //progress dialog
  static ProgressDialog showLoader(BuildContext context) {
    return ProgressDialog(context, isDismissible: false,
        customBody: Container(
          height: 70,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(2.0),
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor),
                  backgroundColor: AppColors.lightGreyColor,
                ),
              ),
              SizedBox(width: 15,),
              Text(AppTranslations.of(context).text(Strings.strPleaseWait),
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.none,
                      fontSize: 14.0)),
            ],
          ),
        ));
  }

  //display SnackBar
  static void displaySnackBar(GlobalKey<ScaffoldState> scaffoldKey, String msg) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(msg)));
  }

  //change date format
  static String formatDateMonth(String date) {
    return DateFormat('d-MMM-yyyy')
        .format(DateFormat("yyyy-MM-dd'T'hh:mm:ss").parse(date));
  }
}
