import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ydrs_desktop_app/blocs/login/login_bloc.dart';
import 'package:ydrs_desktop_app/common/app_alertbox.dart';
import 'package:ydrs_desktop_app/common/app_colors.dart';
import 'package:ydrs_desktop_app/common/app_constants.dart';
import 'package:ydrs_desktop_app/common/app_icons.dart';
import 'package:ydrs_desktop_app/common/app_internet_error.dart';
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/common/app_text.dart';
import 'package:ydrs_desktop_app/network/repo/local/preference/local_storage.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/patients_list.dart';
import 'package:ydrs_desktop_app/ui/security_pin_screen/create_security_pin.dart';
import 'package:ydrs_desktop_app/utils/route_generator.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<State> _keyLoader = GlobalKey<State>();
final _emailKey = GlobalKey<FormFieldState>();
final _passwordKey = GlobalKey<FormFieldState>();

class LoginScreen extends StatefulWidget {
  static const String routeName = '/Login';

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _passwordVisible;
  bool isInternetAvailable = false;

  //Text editing Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  // DropdownService _services = DropdownService();
  // QuickAppointmentService _appointmentService = QuickAppointmentService();
  // Services appServices = Services();
  AnimationController _controller;
  Animation _animation;
  FocusNode _focusNode = FocusNode();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 12.0, end: 12.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
    //drop down service file

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    //drop down service file
    // _services.getExternalAttachmnetDocumentType();
    // _appointmentService.getQuickCaseType();
    // _appointmentService.getCaseTypeStates();
    // _services.getAppointmentTypeList();
    // _appointmentService.loadTimeSlots();
    _passwordVisible = false;
    _checkInternet();
    super.initState();
  }

  /// dispose method
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Play Animation on click of SignInButton
  void _playLoginAnimation() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      // await _loginButtonAnimationController.forward();
    } on TickerCanceled {}
  }

  // To Reset the Animation Controller
  void resetAnimatedButtonSize() {
    setState(() {
      _isLoading = false;
    });
  }

  // Check for InterNet Connection
  Future<void> _checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isInternetAvailable = true;
      });
    } else {
      setState(() {
        isInternetAvailable = false;
      });
      showInternetError(context, _keyLoader);
    }
  }

  // for checking user is login first time.
  void setIsItFirstTime(String memberId) async {
    await MySharedPreferences.instance
        .setStringValue(Keys.isItFirstTime, "yes");
    // await getDropDownData(memberId);
  }

  // DialogBox to show the popup message if user credentials are wrong
  void _alertMessage(String titleText, String contentText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            titleText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.regular,
            ),
          ),
          content: Text(
            contentText,
            style: TextStyle(
                fontFamily: AppFonts.regular,
                color: CustomizedColors.yourDoctorsTextColor,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppStrings.ok,
                style: TextStyle(
                    fontFamily: AppFonts.regular,
                    fontSize: 15,
                    color: CustomizedColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocListener<LoginBloc, FormScreenState>(
      listener: (context, state) {
        if (state.errorMsg != null ||
            state.isExceptionError != null ||
            state.unHandledException != null) {
          customAlertMessage(AppStrings.serverError, context);
          resetAnimatedButtonSize();
        }
        // if the status code is true i.e 200 it execute the statement
        // else go to next statement
        else if (state.isTrue == true) {
          //for setting value in shared preference.
          setIsItFirstTime(state.memberId);
          //checking for particular member pin is available or not.
          //based on that we are navigating user to respective screens.
          if (state.isPinAvailable == true) {
            RouteGenerator.navigatorKey.currentState.pushReplacementNamed(
                DemographicPage.routeName,
                arguments: state.memberId);
          } else {
            //Route navigation to Create Pin Screen
            RouteGenerator.navigatorKey.currentState.pushReplacementNamed(
              CreatePinScreen.routeName,
            );
          }
        } else {
          resetAnimatedButtonSize();
          _alertMessage(
              AppStrings.incorrectCredentials, AppStrings.wrongCredentialsMsg);
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _text(),
                  _welcomeText(),
                  _yourDoctorsText(),
                  _formField(),
                  _signInButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Container for your doctor text with image
  Widget _text() {
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        //which add Row properties at the center
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Image.asset(
              AppImages.doctorImg,
              height: height < 600 ? height * 0.08 : height * 0.1,
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: height * 0.060, top: height * 0.12),
    );
  }

  /// Container for welcome screen Text
  Widget _welcomeText() {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return Container(
      child: Text(
        AppStrings.welcome_text,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            letterSpacing: 1,
            color: Colors.grey),
      ),
      margin: EdgeInsets.only(bottom: height * 0.03),
    );
  }

  /// Container for your_doctors quote text
  // ignore: non_constant_identifier_names
  Widget _yourDoctorsText() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height * 0.2,
          maxWidth: width * 0.9,
        ),
        child: Text(
          AppStrings.your_doctor_text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: AppFonts.regular,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
      ),
      margin: EdgeInsets.only(bottom: height * 0.04),
    );
  }

  /// Form field to validate the user input
  Widget _formField() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Form(
      // key: _formKey,
      child: Column(
        children: [
          SizedBox(height: _animation.value),
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            height: width < 600 ? null : height * 0.055,
            width: width < 600 ? width * 0.85 : width * 0.7,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              key: _emailKey,
              onChanged: (value) {
                _emailKey.currentState.validate();
              },
              inputFormatters: [
                //for disabling white spaces in form field
                FilteringTextInputFormatter.deny(
                    RegExp(AppConstants.ignoreSpace))
              ],
              focusNode: _focusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return AppStrings.enter_email;
                }
                return null;
              },
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: AppStrings.email_text_field_hint,
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: width < 600 ? width * 0.04 : width * 0.02,
                ),
              ),
            ),
          ),
          SizedBox(height: _animation.value),
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            height: width < 600 ? null : height * 0.055,
            width: width < 600 ? width * 0.85 : width * 0.7,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              key: _passwordKey,
              onChanged: (value) {
                _passwordKey.currentState.validate();
              },
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                    RegExp(AppConstants.ignoreSpace))
              ],
              validator: (value) {
                if (value.isEmpty) {
                  return AppStrings.enter_password;
                }
                return null;
              },
              focusNode: focusNode,
              controller: passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey.shade500),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                hintText: AppStrings.password_text_field_hint,
                hintStyle: TextStyle(
                    fontSize: width < 600 ? width * 0.04 : width * 0.02,
                    color: Colors.grey.shade500),
              ),
            ),
          ),
          SizedBox(height: height * 0.06),
        ],
      ),
    );
  }

  /// Onclick of sign in  Button check the user credentials if true then navigated to next screen
  Widget _signInButton() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: GestureDetector(
        onTap: () async {
          FocusScope.of(context).unfocus();
          //will check for internet connection before sending data to Api.
          await _checkInternet();
          if (isInternetAvailable == true) {
            if (_emailKey.currentState.validate() &&
                _passwordKey.currentState.validate()) {
              _playLoginAnimation();
              BlocProvider.of<LoginBloc>(context).add(FormScreenEvent(
                  emailController.text, passwordController.text));
            } else {
              return null;
            }
          }
        },
        child: Container(
          height: width < 600 ? height * 0.058 : height * 0.055,
          width: width < 600 ? width * 0.85 : width * 0.7,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
              color: CustomizedColors.primaryColor,
              borderRadius: BorderRadius.all(const Radius.circular(15.0))),
          child: !_isLoading
              ? Text(
                  AppStrings.sign_in,
                  style: TextStyle(
                      fontFamily: AppFonts.regular,
                      fontWeight: FontWeight.bold,
                      fontSize: width < 600 ? width * 0.04 : width * 0.025,
                      color: CustomizedColors.signInTextColor),
                )
              : CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
        ),
      ),
    );
  }

  //get drop down data and saving to local db
  // getDropDownData(String memberId) async {
  //   await appServices.getLocations(memberId);
  //   await appServices.getProvider(memberId);
  //   await _services.getPratice(memberId);
  // }
}
