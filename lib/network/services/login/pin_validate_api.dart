import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/network/models/login/pin_validate_model.dart';

class PinRepo {
  // ignore: missing_return
  Future<PinResponse> pinVerifyPostApiMethod(
      String memberId, String pin) async {
    var client = http.Client();
    try {
      var endpointUrl = ApiUrlConstants.getUserValidate;
      Map<String, dynamic> queryParams = {
        'MemberId': memberId,
        'Pin': pin,
        "FingerPrintValidation": "false",
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;

      final response = await client.get(Uri.parse(requestUrl), headers: {
        "Accept": "application/json"
      }).timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(AppStrings.timeOutError);
      });

      if (response.statusCode == 200) {
        PinResponse pinResponse = parsePinResponse(response.body);
        return pinResponse;
      }
    } catch (e) {
      // print(e.toString());
      throw (e);
    } finally {
      client.close();
    }
  }

  static PinResponse parsePinResponse(String responseBody) {
    final PinResponse pinResponse =
        PinResponse.fromJson(jsonDecode(responseBody));
    return pinResponse;
  }
}
