import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/controller/appointment_controller.dart';
import 'package:my_cmh_updated/model-new/all_dpt_response.dart';
import 'package:my_cmh_updated/model-new/appointment_lookup_response.dart';

import 'package:my_cmh_updated/model-new/user_info_response.dart' as user;

import 'package:my_cmh_updated/ui/dashboard/appointment/apptmnt_list_widget.dart';
import 'package:my_cmh_updated/ui/dashboard/appointment/online_appointment_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentScreen extends StatefulWidget {
  final List? userInfo;
  final List? appointmentInfo;

  const AppointmentScreen({Key? key, this.userInfo, this.appointmentInfo})
    : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  var appointmentController = GetControllers.shared.getAppointmentController();

  var _saving = false;
  var _loading = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var myChildSize = Size.zero;
  var priorityList = <YList>[];
  var departmentList = <Item>[];
  var departmentName = <Item>[];
  var _selectedPatient;

  // List<HomeItem> homeItems = [
  //   HomeItem(itemName: "Book an\nAppointment", image: 'images/appoint.png'),
  //   HomeItem(
  //       itemName: "Appointment\nTracking", image: 'images/prescription.png'),
  // ];

  Future<void> getAppointmentList() async {
    setState(() => _saving = true);
    await appointmentController.fetchAppointmentList(
      _selectedPatient.personalNumber,
    );
    setState(() => _saving = false);
  }

  Future<void> getAppointmentReload(String personalNumber) async {
    setState(() => _saving = true);
    await appointmentController.fetchAppointmentList(personalNumber);
    setState(() => _saving = false);
  }

  Future<void> getAppointmentLookUp() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OnlineAppointmentScreen(userInfo: widget.userInfo),
      ),
    ).then((value) {
      if (_selectedPatient != null) {
        getAppointmentList();
      }
    });
  }

  @override
  void initState() {
    _selectedPatient = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return LoadingOverlayPro(
      isLoading: _saving,
      backgroundColor: Colors.black.withOpacity(0.7),
      progressIndicator: CircularProgressIndicator(color: colorAccent),
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: colorAccent,
              onPressed: () {
                getAppointmentLookUp();
              },
              child: Icon(Icons.add, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text("click".tr),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                elevation: 0,
                child: Container(
                  child: ListTile(
                    title: Text(
                      'doctor_appointment'.tr,
                      style: TextStyle(
                        fontFamily: FONT_NAME,
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    leading: Image(
                      image: AssetImage("images/appoint.png"),
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Color(0xffE2E2E2)),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text('select_patient'.tr),
                        value: _selectedPatient,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedPatient = newValue;
                            getAppointmentList();
                          });
                        },
                        items: widget.userInfo!.map((userInformation) {
                          var name = "";
                          final personalNumber = userInformation.personalNumber;

                          bool containsSafe(
                            String str,
                            String pattern, {
                            int fromEnd = 1,
                            int length = 1,
                          }) {
                            if (str.length >= fromEnd + length - 1) {
                              final sub = str.substring(
                                str.length - fromEnd,
                                str.length - fromEnd + length,
                              );
                              return sub == pattern;
                            }
                            return false;
                          }

                          if (containsSafe(personalNumber, "W", fromEnd: 2)) {
                            name = "Wife";
                          } else if (containsSafe(
                            personalNumber,
                            "H",
                            fromEnd: 2,
                          )) {
                            name = "Husband";
                          } else if (containsSafe(
                            personalNumber,
                            "S",
                            fromEnd: 2,
                          )) {
                            name = "Son";
                          } else if (containsSafe(
                            personalNumber,
                            "D",
                            fromEnd: 2,
                          )) {
                            name = "Daughter";
                          } else if (containsSafe(
                            personalNumber,
                            "F",
                            fromEnd: 2,
                          )) {
                            name = "Father";
                          } else if (containsSafe(
                            personalNumber,
                            "M",
                            fromEnd: 2,
                          )) {
                            name = "Mother";
                          } else if (personalNumber.contains("FL")) {
                            name = "Father in Law";
                          } else if (personalNumber.contains("ML")) {
                            name = "Mother in Law";
                          } else if (personalNumber.contains("MISC")) {
                            name = "Miscellaneous";
                          } else if (personalNumber.contains("MS")) {
                            name = "Miscellaneous";
                          } else if (containsSafe(
                            personalNumber,
                            "B",
                            fromEnd: 2,
                          )) {
                            name = "Batman";
                          } else {
                            name = "Self";
                          }

                          return DropdownMenuItem<user.Item>(
                            child: Text(
                              '${userInformation.patientName} ($name)',
                            ),
                            value: userInformation,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.65,
                child: DefaultTabController(
                  length: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TabBar(
                          indicatorWeight: 5,
                          labelColor: Color(0xff3FDA85),
                          labelStyle: TextStyle(fontSize: 13),
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(text: 'new_appointment'.tr),
                            Tab(text: 'appointment_history'.tr),
                          ],
                        ),
                        Expanded(
                          child: GetBuilder<AppointmentController>(
                            builder: (controller) {
                              return TabBarView(
                                children: [
                                  AppointmentCard(
                                    appointmentList:
                                        controller.newAppointmentList ?? [],
                                    selectedPatient: _selectedPatient,
                                    context: context,
                                    onCancel: () {
                                      getAppointmentList();
                                    },
                                  ),

                                  AppointmentCard(
                                    appointmentList:
                                        controller.appointmentList ?? [],
                                    selectedPatient: _selectedPatient,
                                    context: context,
                                    onCancel: null,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
