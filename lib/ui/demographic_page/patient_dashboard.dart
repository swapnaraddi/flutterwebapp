// import 'package:mac_os_app/network/services/log_exception/log_exception_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ydrs_desktop_app/common/app_colors.dart';
import 'package:ydrs_desktop_app/common/app_loader.dart';
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/common/app_text.dart';
import 'package:ydrs_desktop_app/network/models/demographic/appoint_count_model.dart';
import 'package:ydrs_desktop_app/network/models/demographic/case_detail_list_model.dart';
import 'package:ydrs_desktop_app/network/models/demographic/document_folder_model.dart';
import 'package:ydrs_desktop_app/network/models/demographic/episode_appointment.dart';
import 'package:ydrs_desktop_app/network/services/demographic/demographic%20.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/documents.dart';

import 'appointment_Screen.dart';

class PatientDashboard extends StatefulWidget {
  static const String routeName = '/CaseDetails';

  @override
  State<StatefulWidget> createState() {
    return PatientDashboardState();
  }
}

class PatientDashboardState extends State<PatientDashboard> {
  DemographicPatientsService getDocumentFolderService =
      DemographicPatientsService();
  AppointmentDataList episodeAppointmentDetailsModel = AppointmentDataList();
  List<EpisodeUpcomingAppointment> episodeAppointmentDetails = List();
  List<EpisodePastAppointment> episodeAppointmentDetailLists = List();
  List documentData = [];
  // LogException _logException = LogException();

  getDocumentFolders() async {
    final Map args = ModalRoute.of(context).settings.arguments;
    CaseDetails caseDetails = args[AppStrings.caseData];
    try {
      DocumentFolderModel documentFolderModel = await getDocumentFolderService
          .geDocumentFolders(caseDetails.episodeId ?? '');
      documentData = (documentFolderModel.episodeDocumentFolder);
    } catch (e) {
      var source = "Dashboard Page";
      var message = "An Exception occurred in the  patient documents ";
      // _logException.logExceptionApi(e, message, source);

      throw (e);
    }
  }

  getUpcomingAppointments() async {
    final Map args = ModalRoute.of(context).settings.arguments;
    CaseDetails caseDetails = args[AppStrings.caseData];
    try {
      episodeAppointmentDetailsModel = await getDocumentFolderService
          .getEpisodeAppointmentList(caseDetails.episodeId ?? '');
      episodeAppointmentDetails =
          (episodeAppointmentDetailsModel.episodeUpcomingAppointment);
      episodeAppointmentDetailLists =
          (episodeAppointmentDetailsModel.episodePastAppointment);
    } catch (e) {
      var source = "Dashboard Page";
      var message = "An Exception occurred in the  patient appointments ";
      // _logException.logExceptionApi(e, message, source);

      throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    CaseDetails caseDetails = args[AppStrings.caseData];
    final Map args1 = ModalRoute.of(context).settings.arguments;
    AppointmentCount appointmentCount = args1[AppStrings.countData];
    final Map args2 = ModalRoute.of(context).settings.arguments;
    var doA = args2[AppStrings.doaDate];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomizedColors.clrCyanBlueColor,
        title: Text(
          AppStrings.casesDetail,
          style: TextStyle(fontFamily: AppFonts.regular),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.casesDetail,
                    style: TextStyle(
                      fontFamily: AppFonts.regular,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: CustomizedColors.blueAppBarColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        // SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.doA,
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                doA,
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.state,
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                caseDetails.stateName ?? '',
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.attorney,
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                caseDetails.attroneyName ?? '',
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.contact,
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                caseDetails.phoneNumber ?? '',
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.insurance,
                    style: TextStyle(
                      fontFamily: AppFonts.regular,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: CustomizedColors.blueAppBarColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        // SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.claimNum,
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                caseDetails.claimNumber ?? '',
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.carrier,
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                caseDetails.payerName,
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.plan,
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                caseDetails.planName,
                                style: TextStyle(
                                  fontFamily: AppFonts.regular,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              width: width,
              height: height * 0.15,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      showLoaderDialog(this.context, text: AppStrings.loading);
                      try {
                        await getUpcomingAppointments();
                        Navigator.of(this.context, rootNavigator: true).pop();

                        Navigator.of(context)
                            .pushNamed(AppointmentScreen.routeName, arguments: {
                          'upcomingDataList': episodeAppointmentDetails,
                          'pastDataList': episodeAppointmentDetailLists
                        });
                      } catch (e) {
                        var source = "Dashboard Page";
                        var message =
                            "An Exception occurred in the  patient appointments ";
                        // _logException.logExceptionApi(e, message, source);

                        throw (e);
                      }
                    },
                    child: Container(
                      width: width * 0.43,
                      height: height * 0.15,
                      color: CustomizedColors.waveBGColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${appointmentCount.appointmentCompletedCount}/${appointmentCount.appointmentsCount}",
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            AppStrings.appointments,
                            style: TextStyle(
                              fontSize: 14.5,
                              fontFamily: AppFonts.regular,
                              fontWeight: FontWeight.bold,
                              color: CustomizedColors.clrCyanBlueColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: width * 0.43,
                    height: height * 0.15,
                    color: CustomizedColors.waveBGColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${appointmentCount.assessementsCount ?? " "}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.regular,
                              fontSize: 30,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppStrings.assements,
                          style: TextStyle(
                            fontSize: 14.5,
                            fontFamily: AppFonts.regular,
                            fontWeight: FontWeight.bold,
                            color: CustomizedColors.clrCyanBlueColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              width: width,
              height: height * 0.15,
              child: Row(
                children: [
                  InkWell(
                    onTap: appointmentCount.documentsFolderCount == null
                        ? null
                        : () async {
                            showLoaderDialog(this.context,
                                text: AppStrings.loading);
                            try {
                              await getDocumentFolders();
                              if (documentData != null) {
                                Navigator.of(this.context, rootNavigator: true)
                                    .pop();
                                // RouteGenerator.navigatorKey.currentState
                                //     .pushNamed(Documents.routeName, arguments: {
                                //   'documentList': documentData,
                                //   'id': caseDetails.episodeId ?? ''
                                // });
                                Navigator.of(context)
                                    .pushNamed(Documents.routeName, arguments: {
                                  'documentList': documentData,
                                  'id': caseDetails.episodeId ?? ''
                                });
                              }
                            } catch (e) {
                              var source = "Dashboard Page";
                              var message =
                                  "An Exception occurred in the  patient appointments ";
                              // _logException.logExceptionApi(e, message, source);

                              throw (e);
                            }
                          },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: width * 0.43,
                      height: height * 0.15,
                      color: CustomizedColors.waveBGColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appointmentCount.documentsFolderCount == null
                              ? Text("0",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.regular,
                                    fontSize: 30,
                                  ))
                              : Text(
                                  "${appointmentCount.documentsFolderCount ?? ""}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.regular,
                                    fontSize: 30,
                                  )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            AppStrings.document,
                            style: TextStyle(
                              fontSize: 14.5,
                              fontFamily: AppFonts.regular,
                              fontWeight: FontWeight.bold,
                              color: CustomizedColors.clrCyanBlueColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: width * 0.43,
                    height: height * 0.15,
                    color: CustomizedColors.waveBGColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${appointmentCount.referalSourceCount ?? ""}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.regular,
                              fontSize: 30,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppStrings.referrals,
                          style: TextStyle(
                            fontSize: 14.5,
                            fontFamily: AppFonts.regular,
                            fontWeight: FontWeight.bold,
                            color: CustomizedColors.clrCyanBlueColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              width: width,
              height: height * 0.15,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: width * 0.43,
                    height: height * 0.15,
                    color: CustomizedColors.waveBGColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${appointmentCount.careTeamMembersCount ?? ""}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.regular,
                              fontSize: 30,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppStrings.care,
                          style: TextStyle(
                            fontSize: 14.5,
                            fontFamily: AppFonts.regular,
                            fontWeight: FontWeight.bold,
                            color: CustomizedColors.clrCyanBlueColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
