import 'dart:async';
// import 'package:mac_os_app/network/services/log_exception/log_exception_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ydrs_desktop_app/common/app_colors.dart';
import 'package:ydrs_desktop_app/common/app_constants.dart';
import 'package:ydrs_desktop_app/common/app_icons.dart';
import 'package:ydrs_desktop_app/common/app_loader.dart';
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/common/app_text.dart';
import 'package:ydrs_desktop_app/common/app_toast_message.dart';
import 'package:ydrs_desktop_app/network/models/demographic/get_patient_details.dart';
import 'package:ydrs_desktop_app/network/models/demographic/get_searched_patients.dart';
import 'package:ydrs_desktop_app/network/repo/local/preference/local_storage.dart';
import 'package:ydrs_desktop_app/network/services/demographic/demographic%20.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/cached_image.dart';
import 'package:ydrs_desktop_app/ui/demographic_page/patient_profile.dart';
import 'package:ydrs_desktop_app/ui/drawer.dart';
import 'package:ydrs_desktop_app/ui/login_screen/loginscreen.dart';
import 'package:ydrs_desktop_app/utils/route_generator.dart';


class DemographicPage extends StatefulWidget {
  static const String routeName = '/DemographicPage';

  @override
  State<StatefulWidget> createState() {
    return DemographicPageState();
  }
}

class DemographicPageState extends State<DemographicPage> {
  var displayName = "";
  var profilePic = "";
  var userProfile = "";
  var date;
  List<PatientList> users = List();
  List<PatientList> filteredUsers = List();
  bool patientSearchIcon = true;
  TextEditingController patientEditingController = TextEditingController();
  bool contains = false;
  int pageNum;
  bool _loading = false;
  bool pageLoading = true;
  GetSearchedPatients allMyList;
  DemographicPatientsService searchPatientService =
      DemographicPatientsService();
  int thresholdValue = 0;
  final _debouncer = Debouncer(milliseconds: 500);
  var _scrollController = ScrollController();
  var patientData, caseData;
  GetPatientDetailsList patientDetailsList = GetPatientDetailsList();
  TextEditingController reasonForAccess = TextEditingController();
  // LogException _logException = LogException();

  // int indexVal;

  @override
  void initState() {
    super.initState();
    _loadData();
    pageNum = 1;
    filteredUsers = [];
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _scrollController.addListener(_onScroll);
  }

  getPatients() {
    _debouncer.run(() async {
      setState(() {
        _loading = true;
      });
      try {
        allMyList = await searchPatientService.getSeacrhedPatients(
            patientEditingController.text, null, pageNum);
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
      } catch (e) {
        var source = "Search patient page";
        var message =
            "An Exception occurred in the patient details while getting data";
        // _logException.logExceptionApi(e, message, source);
      }

      setState(() {
        filteredUsers.addAll(allMyList?.patientList);
        if (allMyList.patientList.length == 0 && pageNum == 1) {
          return AppToast().showToast(AppStrings.toastMsg);
        } else if (allMyList.patientList.length < 50) {
          pageNum = 1;
          pageLoading = false;
        } else {
          pageLoading = true;
          pageNum = pageNum + 1;
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    filteredUsers.clear();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    var currentScroll = _scrollController.position.pixels;
    try {
      if (maxScroll > 0 &&
          currentScroll > 0 &&
          maxScroll == currentScroll &&
          pageLoading) {
        getPatients();
      }
    } catch (e) {
      var source = "Search patient page";
      var message =
          "An Exception occurred in the patient details while getting data";
      // _logException.logExceptionApi(e, message, source);
      throw (e);
    }
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = (prefs.getString(Keys.displayName) ?? '');
      profilePic = (prefs.getString(Keys.displayPic) ?? '');
    });
    contains = profilePic.contains('https');
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DemographicPage()));
    });
  }

  getPatientDetails(int index) async {
    try {
      patientDetailsList = await searchPatientService
          .getPatientDetailsList(filteredUsers[index].patientId);
      patientData = await patientDetailsList.patientDetails;
      caseData = await patientDetailsList.caseDetailsList;
    } catch (e) {
      var source = "Search patient page";
      var message =
          "An Exception occurred in the patient details while getting data";
      // _logException.logExceptionApi(e, message, source);
      throw (e);
    }
  }

  ///cupertino dialog
  _cupertinoShowDialog(int index) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(AppStrings.reasonForAccess,
            style: TextStyle(
              fontFamily: AppFonts.regular,
            )),
        content: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              padding: EdgeInsets.only(left: 5),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(AppConstants.nameRegExp))
                ],
                enableInteractiveSelection: true,
                controller: reasonForAccess,
                decoration: InputDecoration(
                    hintText: AppStrings.reason,
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: AppFonts.regular),
              ),
            )),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(AppStrings.submit),
            onPressed: () async {
              try {
                if (reasonForAccess.text != "") {
                  showLoaderDialog(context, text: AppStrings.loading);
                  await getPatientDetails(index);
                  Navigator.of(context, rootNavigator: true).pop();
                  reasonForAccess.clear();
                  RouteGenerator.navigatorKey.currentState.pushReplacementNamed(
                      DemographicPatientProfile.routeName,
                      arguments: {
                        'patientDetails': patientData,
                        'cases': caseData
                      });
                } else {
                  AppToast().showToast(AppStrings.accessReasonRequired);
                }
              } catch (e) {
                var source = "Search patient page";
                var message =
                    "An Exception occurred in the patient details while getting data";
                // _logException.logExceptionApi(e, message, source);
                throw (e);
              }
            },
          ),
          CupertinoDialogAction(
            child: Text(AppStrings.cancel),
            onPressed: () {
              Navigator.pop(context);
              reasonForAccess.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomizedColors.primaryBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomizedColors.clrCyanBlueColor,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            profilePic != null && profilePic != ""
                ? CachedImage(
                    profilePic,
                    isRound: true,
                    radius: 40.0,
                  )
                : Image.asset(
                    AppImages.defaultImg,
                    width: 40,
                    height: 40,
                  ),
            SizedBox(
              width: 10,
            ),
            Text(
              displayName ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'LogOut',
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();
              RouteGenerator.navigatorKey.currentState
                  .pushReplacementNamed(LoginScreen.routeName);
            },
          )
        ],
      ),
      drawer: DrawerScreen(),
      body: Column(
        children: [
          Container(
            child: _searchBar(),
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        _loading == true && pageNum == 1
                            ? _loader()
                            : Container(),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filteredUsers.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index + 1 == filteredUsers.length &&
                                pageLoading) {
                              if (pageNum == 1) {
                                return null;
                              } else {
                                return _loader();
                              }
                            }
                            return _cardWidget(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///search bar
  _searchBar() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: patientEditingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 10, top: 15),
          enabledBorder: InputBorder.none,
          hintText: AppStrings.search,
          suffixIcon: patientEditingController.text == ""
              ? Icon(Icons.search)
              : IconButton(
                  alignment: Alignment.centerRight,
                  icon: Image.asset(AppImages.clearIcon, width: 20, height: 20),
                  onPressed: () async {
                    filteredUsers = users;
                    setState(() {
                      this.patientSearchIcon = true;
                      pageNum = 1;
                    });
                    patientEditingController.clear();
                    filteredUsers.clear();
                  }),
        ),
        onSubmitted: (string) async {
          setState(() {
            this.patientSearchIcon = false;
            filteredUsers.clear();
          });
          getPatients();
        },
        onChanged: (string) async {
          setState(() {
            if (patientEditingController.text != "") {
              this.patientSearchIcon = false;
              filteredUsers = users;
            }else{
              filteredUsers.clear();
            }
          });
        },
      ), //),
    );
  }

  _cardWidget(int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final PatientList patients = filteredUsers[index];
    String dob = "${patients.dob}" ?? '';

    date = AppConstants.parseDatePattern(dob, AppConstants.mmmdddyyyy);
    return InkWell(
      onTap: () async {
        try {
          if (patients.directAccess == 0) {
            _cupertinoShowDialog(index);
          } else {
            showLoaderDialog(context, text: AppStrings.loading);
            await getPatientDetails(index);
            Navigator.of(context, rootNavigator: true).pop();
            RouteGenerator.navigatorKey.currentState.pushNamed(
                DemographicPatientProfile.routeName,
                arguments: {'patientDetails': patientData, 'cases': caseData});
          }
        } catch (e) {
          var source = "Search patient page";
          var message =
              "An Exception occurred in the patient details while getting data";
          // _logException.logExceptionApi(e, message, source);
          throw (e);
        }
      },
      child: Card(
        elevation: 1,
        child: Container(
          width: width,
          // height: height * 0.12,
          height: patients.directAccess == 0 ? height * 0.12 : height * 0.1,
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: width * 0.45,
                  height: height * 0.1,
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.45,
                          child: Text(patients.displayName ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppFonts.regular)),
                        ),
                        SizedBox(height: 10),
                        Text(
                          date,
                          style: TextStyle(
                            fontFamily: AppFonts.regular,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(width: width * 0.3),
                Container(
                  width: width * 0.45,
                  height: height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${patients.accountNumber}",
                        style: TextStyle(
                          fontFamily: AppFonts.regular,
                          fontSize: 14,
                        ),
                      ),
                      // SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${patients.numberOfCases}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            AppStrings.cases,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 10),
                      patients.directAccess == 0
                          ? Text(
                              AppStrings.requestAccess,
                              style: TextStyle(color: Colors.deepOrangeAccent),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loader() {
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
      ]),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
