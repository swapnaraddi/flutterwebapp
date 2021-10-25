import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ydrs_desktop_app/common/app_icons.dart';
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/ui/login_screen/loginscreen.dart';
import 'package:ydrs_desktop_app/ui/security_pin_screen/verify_security_pin.dart';
import 'package:ydrs_desktop_app/utils/route_generator.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      isInit = false;
      Timer(Duration(seconds: 5), () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var login = prefs.getString(AppStrings.pinAvailable);
        if (login == null || login.isEmpty) {
          RouteGenerator.navigatorKey.currentState
              .pushReplacementNamed(LoginScreen.routeName);
        } else {
          RouteGenerator.navigatorKey.currentState
              .pushReplacementNamed(VerifyPinScreen.routeName);
        }
      });
    }
  }

  Container container(double logoHeight) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppImages.SplashLogo,
                width: width * 0.70,
                //height: height * logoHeight,
              ),
            ),
          ],
        ),
      ),
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: container(0.15));
  }
}
