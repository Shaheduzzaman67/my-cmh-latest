import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/config/app_config.dart';
import 'package:my_cmh_updated/model-new/care_of_request.dart';
import 'package:my_cmh_updated/model-new/prescription_layout_response.dart';
import 'package:my_cmh_updated/model-new/prescription_list_response.dart';
import 'package:my_cmh_updated/model-new/user_info_response.dart' as user;
import 'package:my_cmh_updated/model-new/care_of_response.dart' as careOf;
import 'package:my_cmh_updated/services/networking.dart';
import 'package:my_cmh_updated/ui/reports/pdf_viewer_screen.dart';
//import 'package:open_app_file/open_app_file.dart';

import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

class EmrScreen extends StatefulWidget {
  final List? userInfo;

  const EmrScreen({Key? key, this.userInfo}) : super(key: key);

  @override
  _EmrScreenState createState() => _EmrScreenState();
}

class _EmrScreenState extends State<EmrScreen> {
  static final String baseUrl = AppConfig.apiUrl;
  var _saving = false;

  var myChildSize = Size.zero;
  var careOfPaientInfo = careOf.Info();
  var prescripTionLayout = PresEntity();
  var presCriptionData = <PrescriptionData>[];
  var _selectedPatient;

  Future<void> getPrescription(
    String hospitalId,
    String fromDate,
    String toDate,
  ) async {
    setState(() {
      _saving = true;
    });

    NetworkHelper networkHelper = NetworkHelper();

    await networkHelper.getPrescription(hospitalId, fromDate, toDate).then((
      result,
    ) async {
      setState(() {
        _saving = false;
      });
      if (result != null) {
        presCriptionData = result.obj!.data!;
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

  Future<void> getPrescriptionLayout(
    String doctorNo,
    String prescriptionId,
  ) async {
    setState(() {
      _saving = true;
    });

    NetworkHelper networkHelper = NetworkHelper();

    await networkHelper.getPrescriptionLayout(doctorNo).then((result) async {
      //print(result);
      if (result != null) {
        prescripTionLayout = result.presReportEntity!;
        viewPrescription(prescriptionId, prescripTionLayout.templateLink!);
      } else {
        setState(() {
          _saving = false;
        });
        buildAlertDialogWithChildren(
          context,
          true,
          'information'.tr,
          'saved'.tr,
        );
      }
    });
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
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>");
        careOfPaientInfo = result.obj!.patientInfo!;
        getPrescription(
          careOfPaientInfo.hospitalNumber.toString(),
          '20-Jun-2015',
          DateFormat('dd-MMM-yyyy').format(DateTime.now()),
        );
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

  void viewPrescription(String id, String layout) async {
    String url =
        baseUrl + 'emr-prescription-report?prescriptionId=$id&pLayout=$layout';
    Map<String, String> headers = {'Accept': '*/*'};
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      debugPrint(url);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        setState(() {
          _saving = false;
        });
        Directory appDocDir = await getApplicationDocumentsDirectory();
        if (response.headers['content-type'] == 'application/pdf') {
          final String filePath = '${appDocDir.path}/pdf_file.pdf';
          await File(filePath).writeAsBytes(response.bodyBytes);

          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PdfViewerScreen(filePath: filePath, title: 'Prescription'),
              ),
            );
          }

          //await OpenFile.open(filePath);
        } else {
          setState(() {
            _saving = false;
          });
          print('Unsupported file type');
        }
      } else {
        setState(() {
          _saving = false;
        });
        print('Failed to fetch file');
      }
    } catch (e) {
      setState(() {
        _saving = false;
      });
      print('Error: $e');
    }
  }

  @override
  void initState() {
    _selectedPatient = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayPro(
      isLoading: _saving,
      backgroundColor: Colors.black.withOpacity(0.7),
      progressIndicator: CircularProgressIndicator(color: colorAccent),
      child: Scaffold(
        body: Column(
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
                    'prescription'.tr,
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
            _appointmentCard(),
          ],
        ),
      ),
    );
  }

  Widget _appointmentCard() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return _selectedPatient != null
        ? presCriptionData.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: presCriptionData.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      DateTime date = DateTime.parse(
                        presCriptionData[index].ssCreatedOn!,
                      );
                      String formattedDate = DateFormat(
                        'dd MMM yyyy',
                      ).format(date);
                      return InkWell(
                        onTap: () {
                          getPrescriptionLayout(
                            presCriptionData[index].doctorNo.toString(),
                            presCriptionData[index].id.toString(),
                          );
                        },
                        child: Container(
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
                          child: Row(
                            children: [
                              Container(
                                width: width - width * 0.33,
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "prescription_no".tr,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          presCriptionData[index].id.toString(),
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      presCriptionData[index].departmentName!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Divider(thickness: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "date".tr,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              formattedDate,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: height * 0.12,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  color: Color(0xff3FDA85),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.save_alt_rounded,
                                  size: 45,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.5 - height * 0.18,
                      left: 15,
                      right: 15,
                    ),
                    child: Text(
                      "no_prescription_found".tr,
                      style: TextStyle(fontSize: 25, fontFamily: FONT_NAME),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
        : Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.5 - height * 0.18,
                left: 15,
                right: 15,
              ),
              child: Text(
                "select_patient_first".tr,
                style: TextStyle(fontSize: 25, fontFamily: FONT_NAME),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
