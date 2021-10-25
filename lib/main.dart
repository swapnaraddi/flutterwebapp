import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ydrs_desktop_app/common/app_text.dart';
import 'package:ydrs_desktop_app/network/repo/local/preference/local_storage.dart';
import 'package:ydrs_desktop_app/ui/login_screen/splash_screen.dart';
import 'package:ydrs_desktop_app/ui/security_pin_screen/verify_security_pin.dart';
import 'package:ydrs_desktop_app/utils/route_generator.dart';

import 'common/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var login = prefs.getString(Keys.isPINAvailable);
  runApp(MyApp(login: login));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
    this.login,
  }) : super(key: key);

  final String login;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(
        title: TextStyle(
            fontSize: 15.0,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.regular),
      )),
      debugShowCheckedModeBanner: false,
      title: AppStrings.title,
      home: login == null || login == "" ? SplashScreen() : VerifyPinScreen(),
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: RouteGenerator.navigatorKey,
    );
  }
}
