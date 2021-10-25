// import 'package:mac_os_app/network/services/log_exception/log_exception_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ydrs_desktop_app/common/app_colors.dart';
import 'package:ydrs_desktop_app/common/app_constants.dart';
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/common/app_text.dart';
import 'package:ydrs_desktop_app/network/models/demographic/document_folder_model.dart';
import 'package:ydrs_desktop_app/network/models/demographic/document_list_model.dart';
import 'package:ydrs_desktop_app/network/services/demographic/demographic%20.dart';

class Documents extends StatefulWidget {
  static const String routeName = '/Documents';

  @override
  State<StatefulWidget> createState() {
    return DocumentState();
  }
}

class DocumentState extends State<Documents> {
  bool buttonVisible = false;
  bool hideButton = false;
  DemographicPatientsService getDocumentList = DemographicPatientsService();
  List<EpisodeDocumentList> episodeDocumentLists = List();
  DocumentListModel documentListModel;
  // LogException _logException = LogException();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      buttonVisible = true;
    });
    super.initState();
  }

  ///get documents
  getDocuments(int folderId) async {
    try {
      final Map args1 = ModalRoute.of(context).settings.arguments;
      var id = args1[AppStrings.episodeId];
      documentListModel = await getDocumentList.getDocumentsList(
          id, folderId, null, null, null, null, null);
      episodeDocumentLists = documentListModel.episodeDocumentList;
      return episodeDocumentLists;
    } catch (e) {
      var source = "Service file";
      var message = "An Exception occurred while getting documents data";
      // _logException.logExceptionApi(e, message, source);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    List<EpisodeDocumentFolder> documentList = args[AppStrings.documentData];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomizedColors.clrCyanBlueColor,
        title: Text(AppStrings.document),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: documentList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: (documentList[index]
                                    .totalDocumentCountPerFolder ==
                                0)
                            ? null
                            : () async {
                                try {
                                  if (documentList[index].isExpanded == true) {
                                    setState(() {
                                      documentList[index].isExpanded = false;
                                      if (documentList[index].isExpanded ==
                                          false) {
                                        buttonVisible = true;
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      documentList[index].isExpanded = true;
                                      if (documentList[index].isExpanded ==
                                          true) {
                                        hideButton = true;
                                      }
                                    });
                                  }
                                } catch (e) {
                                  var source = "Service file";
                                  var message =
                                      "An Exception occurred while getting documents data";
                                  // _logException.logExceptionApi(
                                  //     e, message, source);
                                }
                              },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      documentList[index].name,
                                      style: TextStyle(
                                          color:
                                              CustomizedColors.clrCyanBlueColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                                Text(
                                    "${documentList[index].totalDocumentCountPerFolder}",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                (documentList[index].isExpanded == true)
                                    ? Visibility(
                                        visible: hideButton,
                                        child: Icon(Icons.arrow_drop_up),
                                      )
                                    : Visibility(
                                        visible: buttonVisible,
                                        child: Icon(
                                            Icons.arrow_drop_down_outlined))
                              ]),
                        ),
                      ),
                      documentList[index].isExpanded
                          ? expansionListData(index)
                          : Container()
                    ],
                  );
                })),
      ),
    );
  }

  //get document list details
  expansionListData(int index) {
    final Map args = ModalRoute.of(context).settings.arguments;
    List<EpisodeDocumentFolder> documentList = args[AppStrings.documentData];
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder(
          future: getDocuments(documentList[index].id),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                ),
              );
            } else {
              return Container(
                height:
                    snapshot.data.length == 1 ? height * 0.05 : height * 0.18,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: snapshot.data.length == 0
                    ? Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: Text(
                                  AppStrings.nofilesFound,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.regular,
                                    // color: CustomizedColors.clrCyanBlueColor),
                                  ),
                                ))
                          ]))
                    : ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          String date =
                              snapshot.data[index].treatmentDate ?? '';
                          var doa = AppConstants.parseDatePattern(
                              date, AppConstants.mmmdddyyyy);
                          return Container(
                            padding: const EdgeInsets.all(10),
                            color: CustomizedColors.waveBGColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text(
                                    doa,
                                    style: TextStyle(
                                      fontFamily: AppFonts.regular,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    snapshot.data[index].fileName ?? '',
                                    style: TextStyle(
                                      fontFamily: AppFonts.regular,
                                      fontSize: 14.5,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    snapshot.data[index].providerName ?? '',
                                    style: TextStyle(
                                      fontFamily: AppFonts.regular,
                                      fontSize: 14.5,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.white,
                          );
                        }),
              );
            }
          }),
    );
  }
}
