import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/common/sessions.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/ui/dashboard/appointment_screen.dart';
import 'package:my_cmh_updated/ui/dashboard/emr/emr_screen.dart';
import 'package:my_cmh_updated/ui/dashboard/home_screen.dart';
import 'package:my_cmh_updated/ui/dashboard/profile_screen.dart';
import 'package:my_cmh_updated/ui/reports/reports_screen.dart';
import 'package:my_cmh_updated/model-new/appointment_list_response.dart'
    as appointment;

class DashBoardScreen extends StatefulWidget {
  //static String id = '/DashBoardScreen';

  const DashBoardScreen({Key? key}) : super(key: key);
  static _DashBoardScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_DashBoardScreenState>();

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  var appointmentController = GetControllers.shared.getAppointmentController();
  var authController = GetControllers.shared.getAuthController();

  var stateForExit = 0;

  var appointmentList = <appointment.Appointments>[];
  PageController controller = PageController(keepPage: true);
  int currentIndex = 0;
  var itemHeader = [
    "Home",
    "Appointment",
    "Prescription",
    "Reports",
    'Profile',
  ];

  @override
  void initState() {
    releaseTimeSlot();
    //getAppUpdate();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  releaseTimeSlot() async {
    var tempSlotSl = await Session.shared.getSlotData();
    if (tempSlotSl != null && tempSlotSl != '') {
      await appointmentController.releaseRetainTimeSlot(tempSlotSl);
    }
  }

  void getAppUpdate() async {
    await authController.getAndroidVersion();
  }

  @override
  void didUpdateWidget(DashBoardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        color: colorAccent,
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    pageSnapping: true,
                    controller: controller,
                    onPageChanged: (position) {
                      if (!authController.isLoading.value) {
                        Duration sec = Duration(milliseconds: 100);
                        Future.delayed(sec, () async {});
                        setState(() {
                          currentIndex = position;
                        });
                      }
                    },
                    children: <Widget>[
                      // Add children
                      HomeScreen(),
                      AppointmentScreen(
                        userInfo: authController.allUserList,
                        appointmentInfo: appointmentList,
                      ),
                      //PrescriptionScreen(),
                      EmrScreen(userInfo: authController.allUserList),
                      ReportsScreen(userInfo: authController.allUserList),
                      ProfileScreen(),
                      //MoreScreen(),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Color(0xFFF8F8F8),
              iconSize: 18.0,
              elevation: 0,
              backgroundColor: colorAccent,
              unselectedItemColor: Colors.black,
              selectedLabelStyle: GoogleFonts.nunitoSans(
                color: colorPrimary,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: GoogleFonts.nunitoSans(
                color: Color(0xFFBCBFCE),
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
              ),
              currentIndex: currentIndex,
              onTap: (int index) {
                setState(() {
                  currentIndex = index;
                  controller.jumpToPage(index);
                  //controller.animateToPage(index, duration: Duration(milliseconds: 550), curve: Curves.easeInOut);
                });
              }, // this will be set when a new tab is tapped
              items: [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.house, size: 20),
                  label: '${itemHeader[0]}',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("images/appointment.png"),
                    size: 20,
                  ),
                  label: '${itemHeader[1]}',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("images/prescription_b.png"),
                    size: 20,
                  ),
                  label: '${itemHeader[2]}',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("images/prescription_b.png"),
                    size: 20,
                  ),
                  label: '${itemHeader[3]}',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("images/patient.png"), size: 20),
                  label: '${itemHeader[4]}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (currentIndex == 0) {
      if (stateForExit == 0) {
        showColoredToast("Press again to exit the app");
        ++stateForExit;
        Duration sec = Duration(seconds: 3);
        Future.delayed(sec, () {
          stateForExit = 0;
        });
      } else {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    } else {
      setState(() {
        currentIndex = 0;
        controller.jumpToPage(currentIndex);
      });
    }

    return false;
  }
}
