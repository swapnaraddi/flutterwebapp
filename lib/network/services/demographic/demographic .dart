import 'dart:convert';
// import 'package:mac_os_app/network/services/log_exception/log_exception_api.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/network/models/demographic/appoint_count_model.dart';
import 'package:ydrs_desktop_app/network/models/demographic/case_detail_list_model.dart';
import 'package:ydrs_desktop_app/network/models/demographic/document_folder_model.dart';
import 'package:ydrs_desktop_app/network/models/demographic/document_list_model.dart';
import 'package:ydrs_desktop_app/network/models/demographic/episode_appointment.dart';
import 'package:ydrs_desktop_app/network/models/demographic/get_patient_details.dart';
import 'package:ydrs_desktop_app/network/models/demographic/get_searched_patients.dart';
import 'package:ydrs_desktop_app/network/repo/local/preference/local_storage.dart';

class DemographicPatientsService {
  // LogException _logException = LogException();
  var client1 = http.Client();
  Future<GetSearchedPatients> getSeacrhedPatients(
    String searchString,
    String dob,
    int pageKey,
  ) async {
    String apiUrl = ApiUrlConstants.getSearchPatients;
    var memberId =
        await MySharedPreferences.instance.getStringValue(Keys.memberId);
    final json = {
      "searchString": searchString,
      "memberId": int.parse(memberId) ?? null,
      "dob": dob ?? null,
      "page": pageKey ?? 1
    };
    Response response;
    Dio dio = new Dio();
    response = await dio
        .post(apiUrl,
            data: jsonEncode(json),
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }))
        .catchError((e) {
      if (CancelToken.isCancel(e)) {
        // print('$apiUrl: $e');
      }
    });

// ------> checking the condition statusCode success or not if success get data or throw the error <---------
    try {
      if (response.statusCode == 200) {
        GetSearchedPatients searchPatient =
            GetSearchedPatients.fromJson(response.data);
        return searchPatient;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      var source = "Search patient page";
      var message = "An Exception occurred while getting data";
      // _logException.logExceptionApi(
      //     e, message, source);
    }
  }

  ///get demographic patient details
  Future<GetPatientDetailsList> getPatientDetailsList(patientId) async {
    try {
      var endpointUrl = ApiUrlConstants.getPatientDetailsList;
      Map<String, dynamic> queryParams = {
        'PatientId': '$patientId',
      };
      String querryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + querryString;
      final response = await client1
          .get(Uri.parse(requestUrl), headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        GetPatientDetailsList patientDetailsList =
            parsePatientDetails(response.body);
        return patientDetailsList;
      }
    } on Exception catch (e) {
      var source = "Patient Details Page";
      var message = "An Exception occurred in the getting patient details ";
      // _logException.logExceptionApi(e, message, source);

      throw (e);
    } finally {
      // client1.close();
    }

    return null;
  }

  static GetPatientDetailsList parsePatientDetails(String responseBody) {
    final GetPatientDetailsList patientDetailsList =
        GetPatientDetailsList.fromJson(json.decode(responseBody));
    return patientDetailsList;
  }

  //get case details api
  Future<CaseDetailsLists> getPatientCaseDetails(episodeId) async {
    try {
      var endpointUrl = ApiUrlConstants.getCaseDetails;
      Map<String, dynamic> queryParams = {
        'EpisodeId': '$episodeId',
      };
      String querryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + querryString;
      final response = await client1
          .get(Uri.parse(requestUrl), headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        CaseDetailsLists caseDetailsList = parseAllCaseDetails(response.body);
        return caseDetailsList;
      }
    } on Exception catch (e) {
      var source = "Case Details";
      var message =
          "An Exception occurred in the Case Details for the get case details ";
      // _logException.logExceptionApi(e, message, source);

      throw (e);
    }

    return null;
  }

  static CaseDetailsLists parseAllCaseDetails(String responseBody) {
    final CaseDetailsLists allCaseDetails =
        CaseDetailsLists.fromJson(json.decode(responseBody));
    return allCaseDetails;
  }

  //get appointment count api
  Future<AppointmentCountModel> getAllAppointmentCount(int episodeId) async {
    try {
      var endpointUrl = ApiUrlConstants.getAppointmentCount;
      var memberId =
          await MySharedPreferences.instance.getStringValue(Keys.memberId);
      Map<String, dynamic> queryParams = {
        'EpisodeId': "$episodeId",
        'MemberId': memberId,
      };
      String querryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + querryString;
      final response = await client1
          .get(Uri.parse(requestUrl), headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        AppointmentCountModel appointmentCountModel =
            parseAllAppointmentCount(response.body);
        return appointmentCountModel;
      }
    } on Exception catch (e) {
      var source = "Case DetailsPage";
      var message =
          "An Exception occurred in the Case Details for getting the appointment count";
      // _logException.logExceptionApi(e, message, source);

      throw (e);
    } finally {
      // client1.close();
    }

    return null;
  }

  static AppointmentCountModel parseAllAppointmentCount(String responseBody) {
    final AppointmentCountModel appointmentCountModel =
        AppointmentCountModel.fromJson(json.decode(responseBody));
    return appointmentCountModel;
  }

//get document folders
  Future<DocumentFolderModel> geDocumentFolders(episodeId) async {
    try {
      var endpointUrl = ApiUrlConstants.getDocumentFolder;
      var memberId =
          await MySharedPreferences.instance.getStringValue(Keys.memberId);
      Map<String, dynamic> queryParams = {
        'EpisodeId': '$episodeId',
        'MemberId': (memberId) ?? null
      };
      String querryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + querryString;
      final response = await client1
          .get(Uri.parse(requestUrl), headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        DocumentFolderModel documentFolderModel =
            parseAllDocumnetFolders(response.body);
        return documentFolderModel;
      }
    } on Exception catch (e) {
      var source = "Document Page";
      var message =
          "An Exception occurred in the document folder page for the get document folders ";
      // _logException.logExceptionApi(e, message, source);

      throw (e);
    } finally {
      // client1.close();
    }

    return null;
  }

  static DocumentFolderModel parseAllDocumnetFolders(String responseBody) {
    final DocumentFolderModel folderModel =
        DocumentFolderModel.fromJson(json.decode(responseBody));
    return folderModel;
  }

  //get documents api
  Future<DocumentListModel> getDocumentsList(
      int episodeId,
      int docFolderId,
      int providerId,
      int patientId,
      int surgerId,
      int episodeDocumentFolderIds,
      int documentIds) async {
    String apiUrl = ApiUrlConstants.getDocuments;
    var memberId =
        await MySharedPreferences.instance.getStringValue(Keys.memberId);
    final json = {
      "episodeId": episodeId ?? null,
      "episodeDocumentFolderId": docFolderId ?? null,
      "providerId": providerId ?? null,
      "memberId": int.parse(memberId) ?? null,
      "patientId": patientId ?? null,
      "episodeSurgeryDetailsId": surgerId ?? null,
      "episodeDocumentFolderIds": episodeDocumentFolderIds ?? null,
      "documentIds": documentIds ?? null,
      "isActive": true
    };
    Response response;
    Dio dio = new Dio();
    response = await dio
        .post(apiUrl,
            data: jsonEncode(json),
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }))
        .catchError((e) {
      if (CancelToken.isCancel(e)) {
        print('$apiUrl: $e');
      }
    });

// ------> checking the condition statusCode success or not if success get data or throw the error <---------
    try {
      if (response.statusCode == 200) {
        DocumentListModel documentListModel =
            DocumentListModel.fromJson(response.data);
        return documentListModel;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      var source = "Service file";
      var message = "An Exception occurred while getting data";
      // _logException.logExceptionApi(
      //     e, message, source);
    }
  }

  //get appointments list
  Future<AppointmentDataList> getEpisodeAppointmentList(int episodeId) async {
    try {
      var endpointUrl = ApiUrlConstants.getEpisodeAppointment;
      Map<String, dynamic> queryParams = {
        'EpisodeId': '$episodeId',
      };
      String querryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + querryString;
      final response = await client1
          .get(Uri.parse(requestUrl), headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        AppointmentDataList appointmentDataList =
            parseEpisodeAppointment(response.body);
        return appointmentDataList;
      }
    } catch (e) {
      var source = "Appointment Page";
      var message =
          "An Exception occurred in the Appointment folder page for the get appointments ";
      // _logException.logExceptionApi(e, message, source);

      throw (e);
    } finally {
      // client1.close();
    }

    return null;
  }

  static AppointmentDataList parseEpisodeAppointment(String responseBody) {
    final AppointmentDataList appointmentDataList =
        AppointmentDataList.fromJson(json.decode(responseBody));
    return appointmentDataList;
  }
}
