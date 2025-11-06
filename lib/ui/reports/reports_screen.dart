import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf_plus/flutter_html_to_pdf_plus.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/model-new/care_of_request.dart';
import 'package:my_cmh_updated/model-new/emr_radiology_list_response.dart';
import 'package:my_cmh_updated/model-new/investigation_report_request.dart';
import 'package:my_cmh_updated/model-new/investigation_report_request_list.dart';
import 'package:my_cmh_updated/model-new/user_info_response.dart' as user;
import 'package:my_cmh_updated/model-new/emr_investigation_list_response.dart'
    as labReportListDataModel;
import 'package:my_cmh_updated/services/networking.dart';
import 'package:my_cmh_updated/ui/reports/poc_radiology_report.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_cmh_updated/ui/reports/pdf_viewer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_cmh_updated/model-new/care_of_response.dart' as careOf;

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
  var _saving = false;
  var _loading = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var careOfPaientInfo = careOf.Info();

  var _selectedPatient;
  var labReportList = <labReportListDataModel.Item>[];
  var radiologyReportList = <RadiologyReportItem>[];
  Uint8List? fileByteData;
  String? generatedPdfFilePath;
  TabController? _tabController;

  Future<void> getLabReportList(String hospitalId) async {
    setState(() {
      _saving = true;
    });

    NetworkHelper networkHelper = NetworkHelper();
    var req = InvestigationReportListRequest();
    req.hospitalId = hospitalId;
    req.fromDate = '01-Jan-2021';
    req.toDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());

    await networkHelper.getInvestigationReportList(req).then((result) async {
      setState(() {
        _saving = false;
      });
      if (result != null && result.success == true) {
        labReportList = result.items!;
        // Sort by date in descending order (most recent first)
        labReportList.sort((a, b) {
          try {
            DateTime dateA = DateTime.parse(a.invoiceDateTime!);
            DateTime dateB = DateTime.parse(b.invoiceDateTime!);
            return dateB.compareTo(dateA); // Descending order
          } catch (e) {
            return 0;
          }
        });
      } else {
        // buildAlertDialogWithChildren(
        //     context, true, 'information'.tr, 'no-data'.tr);
      }
    });
  }

  Future<void> getRadiologyReportList(String hospitalId) async {
    setState(() {
      _saving = true;
    });

    NetworkHelper networkHelper = NetworkHelper();
    await networkHelper.getRadiologyReportList(hospitalId).then((result) async {
      setState(() {
        _saving = false;
      });
      if (result != null && result.success == true) {
        radiologyReportList = result.items!;
        // Sort by date in descending order (most recent first)
        radiologyReportList.sort((a, b) {
          try {
            DateTime dateA = DateTime.parse(a.imgCaptureDate!);
            DateTime dateB = DateTime.parse(b.imgCaptureDate!);
            return dateB.compareTo(dateA); // Descending order
          } catch (e) {
            return 0; // Keep original order if parsing fails
          }
        });
      } else {
        // buildAlertDialogWithChildren(
        //     context, true, 'information'.tr, 'no-data'.tr);
      }
    });
  }

  Future<void> getRadiologyReport(
    String invoiceID,
    String itemNumber,
    String itemName,
  ) async {
    setState(() {
      _saving = true;
    });

    NetworkHelper networkHelper = NetworkHelper();
    await networkHelper.getRadiologyReportData(invoiceID, itemNumber).then((
      result,
    ) async {
      if (result != null && result.success == true) {
        if (result.obj!.reportText != null) {
          generateExampleDocument(result.obj!.reportText!, itemName);
        } else {
          setState(() {
            _saving = false;
          });
          buildAlertDialogWithChildren(
            context,
            true,
            'information'.tr,
            'no-data'.tr,
          );
        }
      } else {
        setState(() {
          _saving = false;
        });
        buildAlertDialogWithChildren(
          context,
          true,
          'information'.tr,
          'no-data'.tr,
        );
      }
    });
  }

  Future<void> getLabReport(
    String invoiceId,
    int stampNo,
    String testPerform,
    String itemName,
  ) async {
    setState(() {
      _saving = true;
    });

    NetworkHelper networkHelper = NetworkHelper();
    var req = InvestigationReportRequest();
    req.invoiceNo = invoiceId;
    req.stampNo = stampNo;
    req.testPerform = testPerform;

    await networkHelper.getInvestigationRepor(req).then((result) async {
      if (result != null && result.success == true) {
        if (result.obj != null) {
          createPdf(result.obj!, itemName);
        } else {
          setState(() {
            _saving = false;
          });
          buildAlertDialogWithChildren(
            context,
            true,
            'information'.tr,
            'no-data'.tr,
          );
        }
      } else {
        setState(() {
          _saving = false;
        });
        buildAlertDialogWithChildren(
          context,
          true,
          'information'.tr,
          'no-data'.tr,
        );
      }
    });
  }

  createPdf(String base64, String fileName) async {
    try {
      var bytes = base64Decode(base64);
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/$fileName.pdf");
      await file.writeAsBytes(bytes.buffer.asUint8List());
      debugPrint("${output.path}/$fileName.pdf");
      setState(() {
        _saving = false;
      });

      // Navigate to the generic PDF viewer
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PdfViewerScreen(filePath: file.path, title: fileName),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _saving = false;
      });
      debugPrint('Error creating PDF: $e');
      if (mounted) {
        buildAlertDialogWithChildren(
          context,
          true,
          'error'.tr,
          'Failed to load PDF report. Please try again.',
        );
      }
    }
  }

  Future<void> generateExampleDocument(
    String htmlReportContent,
    String fileName,
  ) async {
    try {
      final htmlContent = """$htmlReportContent""";
      Directory appDocDir = await getApplicationDocumentsDirectory();
      final targetPath = appDocDir.path;
      final targetFileName = fileName;

      final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        content: htmlContent,
        configuration: PrintPdfConfiguration(
          targetDirectory: targetPath,
          targetName: targetFileName,
          printSize: PrintSize.A4,
          printOrientation: PrintOrientation.Portrait,
        ),
      );
      generatedPdfFilePath = generatedPdfFile.path;
      setState(() {
        _saving = false;
      });

      // Navigate to the generic PDF viewer
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewerScreen(
              filePath: generatedPdfFilePath!,
              title: fileName,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error generating PDF: $e');
      if (mounted) {
        buildAlertDialogWithChildren(
          context,
          true,
          'error'.tr,
          'Failed to generate PDF report. Please try again.',
        );
      }
    }
  }

  Future<void> getCareOf() async {
    setState(() {
      _saving = true;
    });

    NetworkHelper networkHelper = NetworkHelper();

    var req = CareOfRequest();

    req.personalNumber = _selectedPatient.personalNumber;
    req.serviceCategory = 0.toString();

    await networkHelper.getCareOf(req).then((result) async {
      setState(() {
        _saving = false;
      });
      if (result != null) {
        careOfPaientInfo = result.obj!.patientInfo!;
        if (_tabController!.index == 0) {
          getLabReportList(careOfPaientInfo.hospitalNumber.toString());
        } else {
          getRadiologyReportList(careOfPaientInfo.hospitalNumber.toString());
        }
      } else {
        buildAlertDialogWithChildren(
          context,
          true,
          'information'.tr,
          'saved'.tr,
        );
      }
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_selectedPatient != null) {
          if (_tabController!.index == 0) {
            getLabReportList(careOfPaientInfo.hospitalNumber.toString());
            //databaseController.fetchFavItems(1, callback: () {});
          }
          if (_tabController!.index == 1) {
            getRadiologyReportList(careOfPaientInfo.hospitalNumber.toString());
          }
        }
      });
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
                        setState(() {
                          _selectedPatient = newValue;
                          getCareOf();
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
    );
  }

  Widget _labReportCard() {
    var width = MediaQuery.of(context).size.width;
    return _selectedPatient != null
        ? labReportList.isNotEmpty
              ? ListView.builder(
                  itemCount: labReportList.length ?? 0,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var item = labReportList[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  onPressed: () {
                                    getLabReport(
                                      item.invoiceNo!,
                                      item.stampNo!,
                                      item.testPerform!,
                                      item.itemName!,
                                    );
                                  },
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
        ? radiologyReportList.isNotEmpty
              ? ListView.builder(
                  itemCount: radiologyReportList.length ?? 0,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var item = radiologyReportList[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RadiologyReportViewer(
                                              invoiceNo: item.invoiceNo
                                                  .toString(),
                                              itemNo: item.itemNo.toString(),
                                            ),
                                      ),
                                    );
                                    // getRadiologyReport(
                                    //   item.invoiceNo.toString(),
                                    //   item.itemNo.toString(),
                                    //   item.itemName!,
                                    // );
                                  },
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
                )
        : Center(
            child: Text(
              "select_patient_first".tr,
              style: TextStyle(fontSize: 25, fontFamily: FONT_NAME),
            ),
          );
  }
}
