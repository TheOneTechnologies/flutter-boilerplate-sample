import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_convention/widgets/custom_button_widget.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title, description, button1, button2;
  final VoidCallback callback1, callback2;
  final double width;

  CustomAlertDialog({
    @required this.title,
    @required this.description,
    @required this.button1,
    @required this.button2,
    @required this.callback1,
    @required this.callback2,
    this.width = 0.15,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        CustomButton(
          isIcon: false,
          iconPath: '',
          title: button1,
          width: width,
          height: 40,
          onCallback: callback1,
        ),
        CustomButton(
          isIcon: false,
          iconPath: '',
          title: button2,
          width: 0.15,
          height: 40,
          onCallback: callback2,
        ),
      ],
    );
  }
}
