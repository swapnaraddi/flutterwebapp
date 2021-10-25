import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ydrs_desktop_app/common/app_colors.dart';
import 'package:ydrs_desktop_app/common/app_constants.dart';
import 'package:ydrs_desktop_app/common/app_loader.dart';
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/common/app_text.dart';
import 'package:ydrs_desktop_app/network/models/demographic/appoint_count_model.dart';
import 'package:ydrs_desktop_app/network/models/demographic/case_detail_list_model.dart';
import 'package:ydrs_desktop_app/network/models/demographic/get_patient_details.dart';
import 'package:ydrs_desktop_app/network/services/demographic/demographic%20.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/cached_image.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/patient_dashboard.dart';
import 'package:ydrs_desktop_app/utils/route_generator.dart';

class DemographicPatientProfile extends StatefulWidget {
  static const String routeName = '/DemographicPatientProfile';

  @override
  State<StatefulWidget> createState() {
    return DemographicPatientProfileState();
  }
}

class DemographicPatientProfileState extends State<DemographicPatientProfile> {
  var caseDatas;
  var countData;
  DemographicPatientsService patientDetailsService =
      DemographicPatientsService();
  GetPatientDetailsList patientDetailsList = GetPatientDetailsList();
  // LogException _logException = LogException();

//get case details
  getCases(int index) async {
    final Map args = ModalRoute.of(context).settings.arguments;
    List<CaseDetailsList> caseDetails = args[AppStrings.casesCount];
    try {
      CaseDetailsLists data = await patientDetailsService
          .getPatientCaseDetails(caseDetails[index].episodeId ?? '');
      caseDatas = data.caseDetails;
    } catch (e) {
      var source = "Case DetailsPage";
      var message =
          "An Exception occurred in the Case Details for getting the case details";
      // _logException.logExceptionApi(e, message, source);

      throw (e);
    }
  }

//get appointment count
  getAppointmentCount(int index) async {
    final Map args = ModalRoute.of(context).settings.arguments;
    List<CaseDetailsList> caseDetails = args[AppStrings.casesCount];
    try {
      AppointmentCountModel appointmentCountModel = await patientDetailsService
          .getAllAppointmentCount(caseDetails[index].episodeId ?? '');
      countData = appointmentCountModel.appointmentCount;
    } catch (e) {
      var source = "Case DetailsPage";
      var message =
          "An Exception occurred in the Case Details for getting the appointment count";
      // _logException.logExceptionApi(e, message, source);

      throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    PatientDetails patientData = args[AppStrings.patientDetail];
    final Map args1 = ModalRoute.of(context).settings.arguments;
    List caseDetails = args1[AppStrings.casesCount];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text(" ",
              style: TextStyle(fontSize: 14, fontFamily: AppFonts.regular)),
          backgroundColor: CustomizedColors.primaryBgColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: CustomizedColors.primaryBgColor),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.05),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            width: 80,
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: CachedImage(
                                null,
                                isRound: true,
                                radius: 35.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 0.1),
                        Text(
                          patientData?.patientName ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: AppFonts.regular,
                              fontWeight: FontWeight.bold,
                              color: CustomizedColors.clrCyanBlueColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${patientData?.gender ?? ''} ${(patientData?.dob ?? '')}  ',
                          style: TextStyle(
                              fontSize: 14.5, fontFamily: AppFonts.regular),
                        ),
                        patientData?.age == null
                            ? Text(' ')
                            : Text(AppStrings.age +
                                " " '${(patientData?.age) ?? ''}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: width,
                  height: height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        AppStrings.contact,
                        style: TextStyle(
                            fontFamily: AppFonts.regular,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: width * 0.9,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: CustomizedColors.clrCyanBlueColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.phone,
                                    style: TextStyle(
                                      fontFamily: AppFonts.regular,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    patientData?.phoneNumber ?? '',
                                    style: TextStyle(
                                      fontFamily: AppFonts.regular,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.email,
                                    style: TextStyle(
                                      fontFamily: AppFonts.regular,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        patientData?.email ?? '',
                                        textAlign: TextAlign.end,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: AppFonts.regular,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.address,
                                    style: TextStyle(
                                      fontFamily: AppFonts.regular,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        patientData?.address ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontFamily: AppFonts.regular,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppStrings.casesList,
                        style: TextStyle(
                            fontFamily: AppFonts.regular,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: caseDetails.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _caseDetails(index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  //case details
  _caseDetails(int index) {
    final Map args = ModalRoute.of(context).settings.arguments;
    List caseDetails = args[AppStrings.casesCount];
    String dob = caseDetails[index].doa.toString() ?? '';
    var date = AppConstants.parseDatePattern(dob, AppConstants.mmmdddyyyy);
    return Column(
      children: [
        InkWell(
            onTap: () async {
              try {
                showLoaderDialog(this.context, text: AppStrings.loading);
                await getCases(index);
                await getAppointmentCount(index);
                if (caseDatas != null && countData != null) {
                  Navigator.of(this.context, rootNavigator: true).pop();
                  RouteGenerator.navigatorKey.currentState
                      .pushNamed(PatientDashboard.routeName, arguments: {
                    'caseDatas': caseDatas,
                    'countData': countData,
                    'doa': date
                  });
                  // Navigator.of(context).pushNamed(PatientDashboard.routeName,
                  //     arguments: {
                  //       'caseDatas': caseDatas,
                  //       'countData': countData,
                  //       'doa': date
                  //     });
                }
              } catch (e) {
                var source = "Case DetailsPage";
                var message =
                    "An Exception occurred in the Case Details for getting the details";
                // _logException.logExceptionApi(e, message, source);

                throw (e);
              }
            },
            child: Container(
              color: CustomizedColors.waveBGColor,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppStrings.doA,
                    style: TextStyle(
                      fontFamily: AppFonts.regular,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: AppFonts.regular,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    AppStrings.cases,
                    style: TextStyle(
                      fontFamily: AppFonts.regular,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    caseDetails[index].caseNum ?? '',
                    style: TextStyle(
                      fontFamily: AppFonts.regular,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(height: 5),
      ],
    );
  }
}
