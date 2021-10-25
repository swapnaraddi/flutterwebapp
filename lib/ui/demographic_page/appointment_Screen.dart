import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ydrs_desktop_app/common/app_colors.dart';
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/common/app_text.dart';
import 'appointment_past.dart';
import 'appointment_upcoming.dart';

class AppointmentScreen extends StatefulWidget {
  static const String routeName = '/AppointmentScreen';
  @override
  State<StatefulWidget> createState() {
    return AppointmentScreenState();
  }
}

class AppointmentScreenState extends State<AppointmentScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomizedColors.clrCyanBlueColor,
        title: Text(
          AppStrings.appointment,
          style: TextStyle(fontFamily: AppFonts.regular),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              child: Container(
                child: TabBar(
                  tabs: [
                    Tab(
                        child: Text(
                      AppStrings.upcoming,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFonts.regular,
                          color: CustomizedColors.clrCyanBlueColor),
                    )),
                    Tab(
                      child: Text(
                        AppStrings.past,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppFonts.regular,
                            color: CustomizedColors.clrCyanBlueColor),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(boxShadow: [
                  new BoxShadow(
                    color: Colors.white,
                  ),
                ]),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UpComingAppointments(),
                  AppointmentPast(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loader(String msg) {
    return Center(
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 25,
        ),
        CupertinoActivityIndicator(
          radius: 20,
        ),
        SizedBox(
          width: 35,
        ),
        Text(
          msg,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.regular),
        )
      ]),
    );
  }
}
