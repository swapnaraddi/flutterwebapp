import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ydrs_desktop_app/blocs/login/login_bloc.dart';
import 'package:ydrs_desktop_app/network/services/login/login_service.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/appointment_Screen.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/documents.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/patient_dashboard.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/patient_profile.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/patients_list.dart';
import 'package:ydrs_desktop_app/ui/login_screen/loginscreen.dart';
import 'package:ydrs_desktop_app/ui/login_screen/splash_screen.dart';
import 'package:ydrs_desktop_app/ui/security_pin_screen/confirm_pin.dart';
import 'package:ydrs_desktop_app/ui/security_pin_screen/create_security_pin.dart';
import 'package:ydrs_desktop_app/ui/security_pin_screen/verify_security_pin.dart';

class RouteGenerator {
  static final navigatorKey = new GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // print("RouteGenerator->name=${settings.name}");
    switch (settings.name) {
      case PatientDashboard.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PatientDashboard(),
        );
      case DemographicPage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DemographicPage(),
        );
      case DemographicPatientProfile.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DemographicPatientProfile(),
        );
      case Documents.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Documents(),
        );

      case AppointmentScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AppointmentScreen(),
        );
      case VerifyPinScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => VerifyPinScreen(),
        );
      case CreatePinScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CreatePinScreen(),
        );
      case ConfirmPinScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ConfirmPinScreen(),
        );
      case SplashScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SplashScreen(),
        );

      case LoginScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => LoginBloc(LoginApiServices()),
            child: LoginScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
