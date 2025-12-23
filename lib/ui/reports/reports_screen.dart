import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/controller/reports_controller.dart';
import 'package:my_cmh_updated/model-new/emr_investigation_list_response.dart'
    as labReportListDataModel;
import 'package:my_cmh_updated/model-new/emr_radiology_list_response.dart';
import 'package:my_cmh_updated/model-new/user_info_response.dart' as user;
import 'package:my_cmh_updated/ui/reports/pdf_viewer_screen.dart';
import 'package:my_cmh_updated/ui/reports/poc_radiology_report.dart';

class ReportsScreen extends StatefulWidget {
  final List? userInfo;
  final List? appointmentInfo;

  const ReportsScreen({Key? key, this.userInfo, this.appointmentInfo})
    : super(key: key);

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with TickerProviderStateMixin {
  late final ReportsController _controller;
  late final TabController _tabController;

  var _selectedPatient;

  @override
  void initState() {
    super.initState();
    _controller = GetControllers.shared.getReportsController();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_selectedPatient == null) return;

    final hospitalNumber =
        _controller.careOfPatientInfo.value.hospitalNumber?.toString() ?? '';

    if (_tabController.index == 0) {
      _controller.fetchLabReportList(hospitalNumber);
    } else if (_tabController.index == 1) {
      _controller.fetchRadiologyReportList(hospitalNumber);
    }
  }

  Future<void> _onPatientSelected(user.Item patient) async {
    setState(() {
      _selectedPatient = patient;
    });

    final success = await _controller.fetchCareOfInfo(
      personalNumber: patient.personalNumber ?? '',
      serviceCategory: '0',
    );

    if (success) {
      final hospitalNumber =
          _controller.careOfPatientInfo.value.hospitalNumber?.toString() ?? '';

      if (_tabController.index == 0) {
        await _controller.fetchLabReportList(hospitalNumber);
      } else {
        await _controller.fetchRadiologyReportList(hospitalNumber);
      }
    } else if (mounted) {
      buildAlertDialogWithChildren(
        context,
        true,
        'information'.tr,
        _controller.errorMessage.value.isNotEmpty
            ? _controller.errorMessage.value
            : 'Failed to fetch patient information',
      );
    }
  }

  Future<void> _onViewLabReport(labReportListDataModel.Item item) async {
    final filePath = await _controller.fetchLabReportPdf(
      itemID: item.itemId!,
      invoiceId: item.invoiceNo!,
      stampNo: item.stampNo!,
      testPerform: item.testPerform!,
      itemName: item.itemName!,
    );

    if (filePath != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PdfViewerScreen(filePath: filePath, title: item.itemName!),
        ),
      );
    } else if (mounted) {
      if (item.testPerform == 'CMH LAB') {
        return;
      }

      buildAlertDialogWithChildren(
        context,
        true,
        'Error'.tr,
        _controller.errorMessage.value.isNotEmpty
            ? _controller.errorMessage.value
            : 'Failed to load PDF report. Please try again.',
      );
    }
  }

  void _onViewRadiologyReport(RadiologyReportItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RadiologyReportViewer(
          invoiceNo: item.invoiceNo.toString(),
          itemNo: item.itemNo.toString(),
        ),
      ),
    );
  }

  String _getPatientRelationship(String personalNumber) {
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

    if (containsSafe(personalNumber, "W", fromEnd: 2)) return "Wife";
    if (containsSafe(personalNumber, "H", fromEnd: 2)) return "Husband";
    if (containsSafe(personalNumber, "S", fromEnd: 2)) return "Son";
    if (containsSafe(personalNumber, "D", fromEnd: 2)) return "Daughter";
    if (containsSafe(personalNumber, "F", fromEnd: 2)) return "Father";
    if (containsSafe(personalNumber, "M", fromEnd: 2)) return "Mother";
    if (containsSafe(personalNumber, "B", fromEnd: 2)) return "Batman";
    if (personalNumber.contains("FL")) return "Father in Law";
    if (personalNumber.contains("ML")) return "Mother in Law";
    if (personalNumber.contains("MISC")) return "Miscellaneous";
    if (personalNumber.contains("MS")) return "Miscellaneous";
    return "Self";
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Obx(
      () => LoadingOverlayPro(
        isLoading: _controller.isLoading.value,
        backgroundColor: Colors.black.withOpacity(0.7),
        progressIndicator: CircularProgressIndicator(color: colorAccent),
        child: Scaffold(
          body: Column(
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
                      'reports'.tr,
                      style: TextStyle(
                        fontFamily: FONT_NAME,
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    leading: Image(
                      image: AssetImage("images/prescription.png"),
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
                          if (newValue != null) {
                            _onPatientSelected(newValue as user.Item);
                          }
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
                              userInformation.patientName +
                                  ' ' +
                                  '(' +
                                  name +
                                  ')',
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TabBar(
                        controller: _tabController,
                        indicatorWeight: 5,
                        labelColor: Color(0xff3FDA85),
                        labelStyle: TextStyle(fontSize: 13),
                        unselectedLabelColor: Colors.black,
                        isScrollable: false,
                        tabs: [
                          Tab(text: 'opd_reports'.tr),
                          Tab(text: 'radiology_reports'.tr),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [_labReportCard(), _radiologyReportCard()],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labReportCard() {
    var width = MediaQuery.of(context).size.width;
    return _selectedPatient != null
        ? Obx(
            () => _controller.labReportList.isNotEmpty
                ? ListView.builder(
                    itemCount: _controller.labReportList.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var item = _controller.labReportList[index];
                      DateTime date = DateTime.parse(item.invoiceDateTime!);
                      String formattedDate = DateFormat(
                        'dd MMM yyyy',
                      ).format(date);
                      return Container(
                        width: width,
                        margin: EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffE5E5E5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "invoice_number".tr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.invoiceNo!,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "report".tr,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        ' : ' + (item.testPerform ?? ''),
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    item.itemName! + ' , ' + item.buName!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(thickness: 2),
                              Row(
                                children: [
                                  Text(
                                    "date:".tr,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(formattedDate),
                                  Spacer(),
                                  ElevatedButton.icon(
                                    onPressed: () => _onViewLabReport(item),
                                    icon: Icon(
                                      Icons.save_alt_rounded,
                                    ), // Icon to display
                                    label: Text(
                                      'view_report'.tr,
                                    ), // Text label for the button
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(
                                        0xff3FDA85,
                                      ), // Button background color
                                      foregroundColor: Colors
                                          .white, // Text color on the button
                                      elevation: 4, // Elevation (shadow)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "no_report_found".tr,
                      style: TextStyle(fontSize: 25, fontFamily: FONT_NAME),
                    ),
                  ),
          )
        : Center(
            child: Text(
              "select_patient_first".tr,
              style: TextStyle(fontSize: 25, fontFamily: FONT_NAME),
            ),
          );
  }

  Widget _radiologyReportCard() {
    var width = MediaQuery.of(context).size.width;
    return _selectedPatient != null
        ? Obx(
            () => _controller.radiologyReportList.isNotEmpty
                ? ListView.builder(
                    itemCount: _controller.radiologyReportList.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var item = _controller.radiologyReportList[index];
                      DateTime date = DateTime.parse(item.imgCaptureDate!);
                      String formattedDate = DateFormat(
                        'dd MMM yyyy',
                      ).format(date);
                      return Container(
                        width: width,
                        margin: EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffE5E5E5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "invoice_number".tr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.invoiceNo.toString(),
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "report".tr,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    item.itemName! + ' , ' + item.buName!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(thickness: 2),
                              Row(
                                children: [
                                  Text(
                                    "date:".tr,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(formattedDate),
                                  Spacer(),
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        _onViewRadiologyReport(item),
                                    icon: Icon(
                                      Icons.save_alt_rounded,
                                    ), // Icon to display
                                    label: Text(
                                      'view_report'.tr,
                                    ), // Text label for the button
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(
                                        0xff3FDA85,
                                      ), // Button background color
                                      foregroundColor: Colors
                                          .white, // Text color on the button
                                      elevation: 4, // Elevation (shadow)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "no_report_found".tr,
                      style: TextStyle(fontSize: 25, fontFamily: FONT_NAME),
                    ),
                  ),
          )
        : Center(
            child: Text(
              "select_patient_first".tr,
              style: TextStyle(fontSize: 25, fontFamily: FONT_NAME),
            ),
          );
  }
}
