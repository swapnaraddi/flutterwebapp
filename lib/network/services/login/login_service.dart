import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/network/models/login/login_model.dart';

class LoginApiServices {
  // LogException _logException = LogException();

  /// passing the controller valued in service
  Future<AuthenticateUser> loginPostApiMethod(
      String name, String password) async {
    var client = http.Client();
    String apiUrl = ApiUrlConstants.getUser;
    final json = {
      "userName": name,
      "password": password,
    };
    try {
      http.Response response = await client.post(
        Uri.parse(apiUrl),
        body: jsonEncode(json),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Access-Control-Allow-Headers": "custId, appId, Origin, Content-Type, Cookie, X-CSRF-TOKEN, Accept, Authorization, X-XSRF-TOKEN, Access-Control-Allow-Origin",
          "Access-Control-Expose-Headers": "Authorization, authenticated",
          "Access-Control-Max-Age": "1728000",
          "Access-Control-Allow-Credentials": "true",
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(AppStrings.timeOutError);
      });

      var jsonResponse = jsonDecode(response.body);
      return AuthenticateUser.fromJson(jsonResponse);
    } catch (e) {
      var source = "Login Screen";
      var message =
          "An Exception occurred in the Login Screen for the LoginApi";
      // _logException.logExceptionApi(e, message, source);

      throw (e);
    } finally {
      client.close();
    }
  }
}
