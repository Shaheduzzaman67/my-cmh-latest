import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/ui/payment/widget/invoice_header.dart';
import 'package:my_cmh_updated/ui/payment/widget/invoice_user_info.dart';
import 'package:my_cmh_updated/ui/payment/widget/payment_bottomsheet.dart';
import 'package:my_cmh_updated/ui/payment/widget/view_details_button.dart';
import 'package:my_cmh_updated/model-new/user_info_response.dart';

class PayBillViews extends StatefulWidget {
  static String id = '/PayBilUpdate';
  PayBillViews({Key? key}) : super(key: key);

  @override
  State<PayBillViews> createState() => _PayBillViewsState();
}

class _PayBillViewsState extends State<PayBillViews> {
  // Sample list of bills with user data.
  var payBillController = GetControllers.shared.payBillController();
  final authControllers = GetControllers.shared.getAuthController();

  InitPaymentResult? lastPaymentResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchBillsForPatient(var patient) async {
    // Call admission API for selected patient
    payBillController.getRegNo(patient.personalNumber, isIPD: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "pay_bill".tr,
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: FONT_NAME,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Column(
        children: [
          // Instruction Text
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Please select a patient first to view their IPD bills',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Patient Selection Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                    value: payBillController.selectedPatient,
                    onChanged: (newValue) async {
                      setState(() {
                        payBillController.selectedPatient = newValue;
                      });
                      await fetchBillsForPatient(newValue);
                    },
                    items: authControllers.allUserList.map((userInformation) {
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

                      if (containsSafe(personalNumber!, "W", fromEnd: 2)) {
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
                      return DropdownMenuItem<Item>(
                        child: Text(
                          userInformation.patientName! + ' ' + '(' + name + ')',
                        ),
                        value: userInformation,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),

          // Admission Bills Content
          Expanded(child: _buildAdmissionTab()),
        ],
      ),
    );
  }

  // Admission Tab Content
  Widget _buildAdmissionTab() {
    return Obx(() {
      if (payBillController.admissionList.isEmpty) {
        return Center(
          child: Text(
            'No admission IPD bills available',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: payBillController.admissionList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final admList = payBillController.admissionList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Main Bill Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFFFFFF), Color(0xFFF9FAFB)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        InvoiceHeader(title: 'IPD', tag: 'ADM IPD'),
                        const SizedBox(height: 20),
                        // Bill ID and Date
                        InvoiceUserInfo(
                          invoiceDate: admList.admissionDate ?? '',
                          invoiceNo: admList.admissionId.toString(),
                          patientname: admList.patientName ?? '',
                          wardName: admList.wardName ?? '',
                        ),

                        const SizedBox(height: 10),

                        ViewDetailsButton(
                          onTap: () {
                            payBillController.getAdmissionSummery(
                              admList.id.toString(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
