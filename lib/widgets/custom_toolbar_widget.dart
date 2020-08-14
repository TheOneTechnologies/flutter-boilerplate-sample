import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_convention/constants/assets.dart';
import 'package:flutter_naming_convention/constants/colors.dart';
import 'package:flutter_naming_convention/constants/font_family.dart';
import 'package:flutter_naming_convention/constants/strings.dart';

class CustomToolbar extends StatelessWidget {
  final String title;
  final int maxLines;
  final bool isDashboardVisible;
  final bool isBackVisible;
  final VoidCallback callback;

  CustomToolbar(
      {this.title, this.maxLines = 1, this.isDashboardVisible = false, this.isBackVisible = false, this.callback});

  @override
  Widget build(BuildContext context) {
    return toolbar(context);
  }

  Widget toolbar(BuildContext context) {

    return Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 55,
                    width: 45,
                    child: Visibility(
                      child: ButtonTheme(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Color.fromRGBO(255, 255, 255, 1),
                          child: Row(
                            key: Key(Strings.strBackKey),
                            children: <Widget>[
                              Image.asset(
                                Assets.backArrow,
                                width: 10,
                                height: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      visible: isBackVisible,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: maxLines,
                          textAlign: TextAlign.center,
                          style: FontFamily.pantonBlackCapsStyle,
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Visibility(
                    child: GestureDetector(
                        onTap: callback,
                        child: Container(
                          height: 25,
                          width: 25,
                          margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Assets.dashboardIcon),
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover),
                              border: Border.all(
                                  color: Colors.transparent, width: 5)),
                        )),
                    visible: isDashboardVisible,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: AppColors.white,
            ),
          ],
        ));
  }
}
