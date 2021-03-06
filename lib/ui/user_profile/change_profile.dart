// /// Code for Work in progress
// import 'dart:convert';
// import 'dart:io';

// import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
// import 'package:YOURDRS_FlutterAPP/common/app_icons.dart';
// import 'package:YOURDRS_FlutterAPP/common/app_loader.dart';
// import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
// import 'package:YOURDRS_FlutterAPP/common/app_text.dart';
// import 'package:YOURDRS_FlutterAPP/network/models/user_profile/change_profile_photo.dart';
// import 'package:YOURDRS_FlutterAPP/network/repo/local/preference/local_storage.dart';
// import 'package:YOURDRS_FlutterAPP/network/services/user_profile/profile_service.dart';
// import 'package:YOURDRS_FlutterAPP/ui/bottom_navigation_bar/bottom_navigation_bar.dart';
// import 'package:YOURDRS_FlutterAPP/utils/cached_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Profile extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return ProfileState();
//   }
// }

// class ProfileState extends State {
//   UserProfile _userProfile = UserProfile();
//   ChangeUserProfile _changeUserProfile = ChangeUserProfile();
//   final picker = ImagePicker();
//   var displayName = "";
//   var displayPic = "";
//   var email = "";
//   File _image;
//   var validateUrl;
//   bool contains, isImageSelected = false;
//   File newImage;

//   @override
//   void initState() {
//     _loadData();
//     validateUrl = Uri.tryParse(displayPic.toString())?.hasAbsolutePath ?? false;
//     super.initState();
//   }

//   void _loadData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       displayName = (prefs.getString(Keys.displayName) ?? '');
//       displayPic = (prefs.getString(Keys.displayPic) ?? '');
//       email = (prefs.getString(Keys.userEmail) ?? '');
//     });
//     contains = displayPic.contains('https');
//   }

//   Future openGallery() async {
//     var pickedFile = await picker.getImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         isImageSelected = true;
//       }
//     });
//   }

//   Future openCamera() async {
//     var pickedFile = await picker.getImage(source: ImageSource.camera);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         isImageSelected = true;
//       }
//     });
//   }

//   _show(BuildContext ctx) {
//     showCupertinoModalPopup(
//       context: ctx,
//       builder: (ctctc) => CupertinoActionSheet(
//           actions: [
//             CupertinoActionSheetAction(
//                 onPressed: () {
//                   openCamera();
//                   Navigator.pop(ctctc);
//                 },
//                 child: Text(
//                   AppStrings.camera,
//                   style: TextStyle(
//                     fontSize: 14.5,
//                     fontFamily: AppFonts.regular,
//                   ),
//                 )),
//             CupertinoActionSheetAction(
//                 onPressed: () {
//                   openGallery();
//                   Navigator.pop(ctctc);
//                 },
//                 child: Text(
//                   AppStrings.PhotoGallery,
//                   style: TextStyle(
//                     fontSize: 14.5,
//                     fontFamily: AppFonts.regular,
//                   ),
//                 )),
//           ],
//           cancelButton: CupertinoActionSheetAction(
//             child: const Text(
//               AppStrings.cancel,
//               style: TextStyle(
//                 fontSize: 14.5,
//                 fontFamily: AppFonts.regular,
//               ),
//             ),
//             isDestructiveAction: true,
//             onPressed: () {
//               Navigator.pop(ctctc);
//             },
//           )),
//     );
//   }

// // // save profile images to a custom folder
//   saveGalleryImageToFolder(String name) async {
//     Directory appDocDirectory;
//     if (Platform.isIOS) {
//       appDocDirectory = await getApplicationDocumentsDirectory();
//     } else {
//       appDocDirectory = await getExternalStorageDirectory();
//     }

//     String path = '${appDocDirectory.path}/${AppStrings.profilePicsfolderName}';
//     final myImgDir = await Directory(path).create(recursive: true);
//     newImage = await File(name).copy(
//       '${myImgDir.path}/${basename(name)}',
//     );
//   }

//   // Show Dialog when ProfilePhoto Updated successful
//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: this.context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: const <Widget>[
//                 Text(
//                   AppStrings.profileSuccess,
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontFamily: AppFonts.regular,
//                       color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text(AppStrings.ok),
//               onPressed: () {
//                 Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(
//                         builder: (context) => CustomBottomNavigationBar()),
//                         (route) => false);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: CustomizedColors.signInButtonColor,
//         title: Text(AppStrings.profileText),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: width,
//           height: height,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 20),
//               Container(
//                 width: 180,
//                 height: 180,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(100),
//                 ),
//                 child: Center(
//                   child: _image == null
//                       ? displayPic != null && displayPic != ""
//                           ? ClipRRect(
//                               borderRadius: BorderRadius.circular(180),
//                               child: CachedImage(
//                                 displayPic,
//                                 isRound: true,
//                                 radius: 180,
//                                 fit: BoxFit.fill,
//                                 // width: 180,
//                                 // height: 180,
//                               ),
//                             )
//                           : Image.asset(
//                               AppImages.defaultImg,
//                               width: 180,
//                               height: 180,
//                             )
//                       : ClipRRect(
//                           borderRadius: BorderRadius.circular(100),
//                           child: Image.file(
//                             File(_image.path),
//                             fit: BoxFit.fill,
//                             width: 180,
//                             height: 180,
//                           ),
//                         ),
//                 ),
//               ),
//               FractionalTranslation(
//                 translation: Offset(0.15, -0.8),
//                 child: Align(
//                   child: InkWell(
//                     onTap: () {
//                       _show(context);
//                     },
//                     child: Card(
//                       color: CustomizedColors.signInButtonColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Icon(
//                           Icons.camera_alt,
//                           size: 25,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Divider(height: 1, thickness: 2),
//               Container(
//                 // color: Colors.amber,
//                 width: width,
//                 height: height * 0.1,
//                 child: Row(
//                   children: [
//                     SizedBox(width: 20),
//                     Icon(
//                       Icons.person,
//                       color: Colors.black45,
//                     ),
//                     SizedBox(width: 30),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           AppStrings.name_text,
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           displayName ?? "",
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                               // color: CustomizedColors.textColor,
//                               fontSize: 18.0,
//                               // fontWeight: FontWeight.bold,
//                               fontFamily: AppFonts.regular),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 70),
//                 child: Divider(height: 1, thickness: 2),
//               ),
//               Container(
//                 // color: Colors.amber,
//                 width: width,
//                 height: height * 0.1,
//                 child: Row(
//                   children: [
//                     SizedBox(width: 20),
//                     Icon(
//                       Icons.email,
//                       color: Colors.black45,
//                     ),
//                     SizedBox(width: 30),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           AppStrings.email,
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           email ?? "",
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                               fontSize: 18.0, fontFamily: AppFonts.regular),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 70),
//                 child: Divider(height: 1, thickness: 2),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 // ignore: deprecated_member_use
//                 child: Visibility(
//                   visible: isImageSelected,
//                   // ignore: deprecated_member_use
//                   child: RaisedButton(
//                       color: Colors.blue,
//                       child: Text(
//                         AppStrings.saveText,
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () async {
//                         showLoaderDialog(context, text: AppStrings.loading);
//                         final fileBytes = await File(_image.path).readAsBytes();
//                         String byteImage = base64Encode(fileBytes);
//                         _changeUserProfile =
//                             await _userProfile.getChangeProfilePhoto(
//                                 byteImage, basename(_image.path));

//                         if (_changeUserProfile.header.statusCode == "200") {
//                           _showMyDialog();
//                         }
//                       }),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
