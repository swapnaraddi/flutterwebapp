
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ydrs_desktop_app/common/app_colors.dart';
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/common/app_text.dart';

customAlertMessage(String msg, BuildContext context) {
  Alert(
    closeIcon: Icon(
      Icons.remove,
      color: Colors.white,
    ),
    closeFunction: () {},
    context: context,
    type: AlertType.none,
    title: msg,
    buttons: [
      DialogButton(
        color: CustomizedColors.primaryColor,
        child: Text(
          AppStrings.ok,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: AppFonts.regular,
          ),
        ),
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        width: 58,
        height: 40,
      )
    ],
  ).show();
}
