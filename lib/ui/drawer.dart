import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ydrs_desktop_app/common/app_colors.dart';
import 'package:ydrs_desktop_app/common/app_icons.dart';
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/common/app_text.dart';
import 'package:ydrs_desktop_app/network/repo/local/preference/local_storage.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/cached_image.dart';

class DrawerScreen extends StatefulWidget {
  static const String routeName = '/DrawerScreen';
  @override
  State<StatefulWidget> createState() {

    return DrawerState();
  }
}

class DrawerState extends State<DrawerScreen> {
  Function function;
  var displayName = "";
  var profilePic = "";
  var userEmail = "";
  var userProfile = "";
  bool contains = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

//loading the data for users profile
  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = (prefs.getString(Keys.displayName) ?? '');
      profilePic = (prefs.getString(Keys.displayPic) ?? '');
      userEmail = (prefs.getString(Keys.userEmail) ?? '');
      userProfile = (prefs.getString(Keys.userProfile) ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.60,
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: CustomizedColors.clrCyanBlueColor,
              ),
              accountName: Text(
                displayName ?? "",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: CustomizedColors.textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.regular),
              ),
              accountEmail: Text(
                userEmail ?? "",
                style: TextStyle(fontFamily: AppFonts.regular),
              ),
              currentAccountPicture: CircleAvatar(
                child: profilePic != null && profilePic != ""
                    ? CachedImage(
                        profilePic,
                        isRound: true,
                        radius: 75.0,
                      )
                    : Image.asset(AppImages.defaultImg),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: CustomizedColors.clrCyanBlueColor,
              ),
              title: Text(
                AppStrings.myProfile,
                style: TextStyle(fontFamily: AppFonts.regular),
              ),
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: CustomizedColors.clrCyanBlueColor,
              ),
              title: Text(
                AppStrings.logout,
                style: TextStyle(fontFamily: AppFonts.regular),
              ),
              onTap: () async {
                // await DatabaseHelper.db.deleteTimeSlotsTable();
                // await DatabaseHelper.db.deleteAppointmentTypesTable();
                // await DatabaseHelper.db.deleteLocationsTable();
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                MySharedPreferences.instance.removeAll();
                // await DatabaseHelper.db.deleteProviders();
                // await DatabaseHelper.db.deletePractices();
                ///  this will reset to homeScreen
                // CustomBottomNavigationBarState.currentTab=0;
                // RouteGenerator.navigatorKey.currentState
                //     .pushReplacementNamed(LoginScreen.routeName);
                },
            ),
          ],
        ),
      ),
    );
  }
}
