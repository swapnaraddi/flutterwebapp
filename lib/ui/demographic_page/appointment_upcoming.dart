import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ydrs_desktop_app/common/app_constants.dart';
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/common/app_text.dart';
import 'package:ydrs_desktop_app/network/models/demographic/episode_appointment.dart';

class UpComingAppointments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UpComingAppointmentsState();
  }
}

class UpComingAppointmentsState extends State<UpComingAppointments> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: width,
        height: height,
        child: _getbody(),
      ),
    );
  }

  Widget _getbody() {
    final Map args = ModalRoute.of(context).settings.arguments;
    List<EpisodeUpcomingAppointment> documentList =
        args[AppStrings.upComingData];
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: (documentList.length == null || documentList.isEmpty)
          ? Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Container(
                      padding: const EdgeInsets.all(30),
                      child: Text(
                        AppStrings.noupcomingappointments,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.regular,
                        ),
                      ))
                ]))
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: documentList.length,
              itemBuilder: (BuildContext context, int index) {
                String date = documentList[index].appointmentDate ?? '';
                var apntDate = AppConstants.parseDatePattern(
                    date, AppConstants.mmmdddyyyy);
                var time =
                    AppConstants.parseDatePattern(date, AppConstants.hhmm);
                return Column(children: [
                  Container(
                      width: width,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            width: width,
                            child: Row(
                              children: [
                                Container(
                                  width: width * 0.45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        apntDate,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          fontFamily: AppFonts.regular,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(documentList[index].appointmentType,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            fontFamily: AppFonts.regular,
                                          )),
                                      SizedBox(height: 8),
                                      Text(
                                        documentList[index].providerName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          fontFamily: AppFonts.regular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width * 0.45,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        time,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          fontFamily: AppFonts.regular,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.location_on_rounded),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5.5,
                                            child: Text(
                                              documentList[index].locationName,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                fontFamily: AppFonts.regular,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Divider(
                                  thickness: 1.0,
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ],
                      ))
                ]);
              }),
    );
  }
}
