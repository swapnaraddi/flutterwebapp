import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ydrs_desktop_app/common/app_colors.dart';

// To display toast messages
class AppToast {
  showToast(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: CustomizedColors.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
