import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:url_launcher/url_launcher.dart';

//const BASE_URL_DEV = "https://cmhmobappapi.tilbd.net/api/mock/";
//const BASE_URL_DEV = "https://cmhmobappapi.tilbd.net/api/v1/";

const APP_URL_BASE = 'https://milapps.itdte.net/';
const APP_URL =
    'https://play.google.com/store/apps/details?id=com.army.itdte.mycmh_patient';
//
//http://192.168.32.9
//const val BASE_URL = "https://cmhapi.tilbd.net/"

/*
*
flutter clean
rm -Rf ios/Pods
rm -Rf ios/.symlinks
rm -Rf ios/Flutter/Flutter.framework
rm -Rf ios/Flutter/Flutter.podspec
rm ios/Podfile
flutter run
*
* */

const cBottomButtonHeight = 55.0;
const cBottomContainerColor = Color(0xFF60BE7F);
const cInactiveCardColor = Color(0xFF111328);
const cCardBackgroundColor = Color(0xFF1C1B2F);
const cActiveCardColor = Color(0xFF1C1B2F);
const colorAccent = Color(0xFF60BE7F);
const colorPrimary = Color(0xFF60BE7F);
const colorPrimaryDark = Color(0xFF60BE7F);
const colorStatusBar = Color(0xFF60BE7F);
const colorLight = Color(0xFFEFFFF6);
const colorGreenLight = Color(0xFFD0FCE3);
const colorRed = Color(0xFFD95252);
const colorYellow = Color(0xFFED8B16);
//
const colorGrey = Color(0xFFF6F6F6);
const colorGreen = Color(0xFF00924E);
const cBackgroundCommon = Color(0xFFF6F6F6);
const yellow = Colors.yellow;
const red = Colors.red;

//

const FONT_NAME = 'abril_regular';
const FONT_NAME2 = 'nunito';

var PUSHER_APP_ID = '1053808';
var PUSHER_APP_KEY = '4da4a88d35b8d74d5311';
var PUSHER_APP_SECRET = '68142b011d0f04d15e81';

//

const cLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFFFFFFFF),
);

Future<void> makePhoneCall(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> buildAlertDialogWithChildren(BuildContext context,
    bool isFullScreen, String _alertTitle, String _alertText) {
  return Dialogs.materialDialog(
      msg: '${_alertText}',
      title: "${_alertTitle}",
      msgStyle: GoogleFonts.lato(color: Colors.black, fontSize: 14),
      titleStyle: GoogleFonts.lato(
          color: colorPrimary, fontSize: 20, fontWeight: FontWeight.bold),
      barrierDismissible: true,
      color: Colors.white,
      context: context,
      actions: [
        TextButton(
          child: Text(
            'ok'.tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ]);
}

Future<void> buildAlertDialogWithChildrenWithFunction(
    BuildContext context,
    bool isFullScreen,
    String _alertTitle,
    String _alertText,
    VoidCallback onOk) {
  return Dialogs.materialDialog(
      msg: '${_alertText}',
      title: "${_alertTitle}",
      msgStyle: GoogleFonts.lato(color: Colors.black, fontSize: 14),
      titleStyle: GoogleFonts.lato(
          color: colorPrimary, fontSize: 20, fontWeight: FontWeight.bold),
      barrierDismissible: true,
      color: Colors.white,
      context: context,
      actions: [
        TextButton(
          child: Text(
            'ok'.tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            onOk();
          },
        ),
      ]);
}

Future<void> buildAlertDialogForAppointment(BuildContext context,
    bool isFullScreen, String _alertTitle, String _alertText,
    {String? departmentName, String? roomName, VoidCallback? onPressed}) {
  return Dialogs.materialDialog(
      msg: '${_alertText}',
      title: "${_alertTitle}",
      msgStyle: GoogleFonts.lato(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      titleStyle: GoogleFonts.lato(
          color: colorPrimary, fontSize: 20, fontWeight: FontWeight.bold),
      msgAlign: TextAlign.center,
      barrierDismissible: true,
      color: Colors.white,
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      customView: Column(
        children: [
          Text(
            departmentName ?? '',
            style: GoogleFonts.lato(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            roomName ?? '',
            style: GoogleFonts.lato(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      context: context,
      actions: [
        TextButton(
          child: Text(
            'ok'.tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
            onPressed?.call();
          },
        ),
      ]);
}

Future<void> buildAlertDialogForAppointmentError(BuildContext context,
    bool isFullScreen, String _alertTitle, String _alertText) {
  return Dialogs.materialDialog(
      msg: '${_alertText}',
      title: "${_alertTitle}",
      msgStyle: GoogleFonts.lato(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      titleStyle: GoogleFonts.lato(
          color: colorPrimary, fontSize: 20, fontWeight: FontWeight.bold),
      barrierDismissible: true,
      color: Colors.white,
      context: context,
      actions: [
        TextButton(
          child: Text(
            'ok'.tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ]);
}

Future<void> buildExitAlertDialogWithChildren(BuildContext context,
    bool isFullScreen, String _alertTitle, String _alertText) {
  return Dialogs.materialDialog(
      msg: '${_alertText}',
      title: "${_alertTitle}",
      msgStyle: GoogleFonts.lato(color: Colors.black, fontSize: 14),
      titleStyle: GoogleFonts.lato(
          color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
      barrierDismissible: true,
      color: Colors.white,
      context: context,
      actions: [
        TextButton(
          child: Text(
            'ok'.tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            if (Platform.isAndroid) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
        ),
      ]);
}

void showSupportDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Support',
              style: TextStyle(
                fontFamily: FONT_NAME,
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('CMH IT Center (01769015949)',
                    style: TextStyle(
                      fontFamily: FONT_NAME2,
                      fontSize: 15.0,
                      color: Colors.black,
                    )),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    Navigator.pop(context);
                    makePhoneCall(
                        'tel: 01769015949'); // Launches the dialer with the given number
                  },
                ),
              ],
            ),
            // Text(
            //   'Whats App & Call',
            //   style: TextStyle(
            //     fontFamily: FONT_NAME,
            //     fontSize: 19.0,
            //     color: Colors.black,
            //   ),
            // ),
            // SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text('ITDSC Support (01769012207)'),
            //   ],
            // ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}

void showColoredToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.black54,
      textColor: Colors.white);
}

void showWhiteToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.white,
      textColor: Colors.black);
}
