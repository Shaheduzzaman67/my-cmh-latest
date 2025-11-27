import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/model-new/pay_bill/invoice_list_response.dart';
import 'package:my_cmh_updated/services/dislog_service.dart';
import 'package:my_cmh_updated/ui/payment/widget/invoice_header.dart';
import 'package:my_cmh_updated/ui/payment/widget/invoice_user_info.dart';
import 'package:my_cmh_updated/ui/payment/widget/pay_status_button.dart';
import 'package:my_cmh_updated/ui/payment/widget/payment_bottomsheet.dart';
import 'package:my_cmh_updated/ui/payment/widget/view_details_button.dart';
import 'package:my_cmh_updated/utils/surjopay_util.dart';
import 'package:my_cmh_updated/model-new/user_info_response.dart';

class PayBillScreen extends StatefulWidget {
  static String id = '/PayBill';
  PayBillScreen({Key? key}) : super(key: key);

  @override
  State<PayBillScreen> createState() => _PayBillScreenState();
}

class _PayBillScreenState extends State<PayBillScreen>
    with SingleTickerProviderStateMixin {
  // Sample list of bills with user data.
  var payBillController = GetControllers.shared.payBillController();
  final authControllers = GetControllers.shared.getAuthController();

  InitPaymentResult? lastPaymentResult;
  bool _isPaymentProcessing = false;

  // Tab Controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() async {
    if (_tabController.indexIsChanging) return; // Only act on completed change
    // Call your API for the selected tab and patient
    await fetchBillsForTabAndPatient(
      tabIndex: _tabController.index,
      patient: payBillController.selectedPatient,
    );
  }

  Future<void> fetchBillsForTabAndPatient({
    required int tabIndex,
    required var patient,
  }) async {
    // Call the appropriate API based on tabIndex and patient
    if (tabIndex == 0) {
      payBillController.getRegNo(patient.personalNumber, isIPD: false);
      // Call Admission API
    } else {
      payBillController.getRegNo(patient.personalNumber, isIPD: true);
      // Call IPD API
    }
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.white, // TabBar background color
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(child: Text('Admission')),
                Tab(child: Text('OPD')),
              ],
              labelColor: Colors.white, // Active tab text color
              unselectedLabelColor: Colors.black, // Inactive tab text color
              indicator: BoxDecoration(
                color: colorAccent,
                borderRadius: BorderRadius.circular(24),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
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
                      await fetchBillsForTabAndPatient(
                        tabIndex: _tabController.index,
                        patient: newValue,
                      );
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

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Admission Tab
                _buildAdmissionTab(),
                // IPD Tab
                _buildIPDTab(),
              ],
            ),
          ),
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
            'No admission bills available',
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
                        InvoiceHeader(title: 'Admission', tag: 'ADM'),
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

  // IPD Tab Content
  Widget _buildIPDTab() {
    return Obx(() {
      if (payBillController.opdList.isEmpty) {
        return Center(
          child: Text(
            'No bills available',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: payBillController.opdList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final opdList = payBillController.opdList[index];
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
                      colors: [Color(0xFFE3F2FD), Color(0xFFF3E5F5)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.04),
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
                        InvoiceHeader(title: 'IPD', tag: 'IPD'),
                        const SizedBox(height: 20),

                        // Bill ID and Date
                        InvoiceUserInfo(
                          invoiceDate: opdList.invoiceDate ?? '',
                          invoiceNo: opdList.invoiceNo.toString(),
                          patientname: opdList.patientName ?? '',
                        ),

                        const SizedBox(height: 12),

                        // Bill Details
                        _buildBillRow(
                          'Total (BDT)',
                          opdList.totalAmt.toString(),
                          isTotal: true,
                        ),
                        const SizedBox(height: 8),
                        _buildBillRow(
                          'Discount',
                          opdList.totalDiscAmt.toString(),
                          isDiscount: true,
                        ),
                        const SizedBox(height: 8),
                        _buildBillRow(
                          'Paid',
                          opdList.totalPayAmt.toString(),
                          isPaid: true,
                        ),
                        const SizedBox(height: 8),
                        _buildBillRow(
                          'Due',
                          opdList.due.toString(),
                          isDue: true,
                        ),
                        const SizedBox(height: 8),

                        // Payment Status
                        PaidButton(
                          dueAmount: opdList.due!.toDouble(),
                          onTap: () {
                            _showPaymentOptions(
                              context,
                              opdList.due?.toDouble() ?? 0.0,
                              opdList.invoiceId.toString(),
                              opdList,
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

  void _showPaymentOptions(
    BuildContext context,
    double fullAmount,
    String invoiceId,
    InvoiceItem invoiceItem,
  ) async {
    final result = await PaymentOptionsBottomSheet.show(
      context,
      fullAmount: fullAmount,
      currency: 'TK',
      onPaymentConfirmed: (paymentResult) async {
        // Handle the payment result from bottom sheet

        double paymentAmount;
        if (paymentResult.paymentType == 'full') {
          paymentAmount = fullAmount;
        } else {
          paymentAmount = paymentResult.customAmount ?? 0;
        }

        if (paymentAmount > 0) {
          // Process payment with the selected amount
          await _handlePayment(
            amount: paymentAmount,
            customOrderId: invoiceId,
            invoiceItem: invoiceItem,
          );
        }
      },
    );

    if (result != null) {
      setState(() {
        lastPaymentResult = result;
      });
    }
  }

  // Helper method for payment handling
  Future<void> _handlePayment({
    required double amount,
    String? customOrderId,
    InvoiceItem? invoiceItem,
  }) async {
    if (_isPaymentProcessing) return;

    setState(() {
      _isPaymentProcessing = true;
    });

    try {
      // Get patient information
      final patientName = invoiceItem?.patientName ?? 'Unknown Patient';

      final patientMobile = invoiceItem?.phoneMobile ?? 'Unknown Number';

      final patientAddress =
          payBillController
              .admissionSummery
              .value
              .model
              ?.patientInfo
              ?.patientAddress ??
          'Unknown Address';
      final patientUnit =
          payBillController
              .admissionSummery
              .value
              .model
              ?.patientInfo
              ?.unitName ??
          'Unknown Address';
      final invoiceId = invoiceItem?.invoiceId?.toString() ?? '';

      // Create payment request
      final paymentRequest = PaymentRequest(
        amount: amount,
        orderID: invoiceId,
        customerName: patientName,
        customerPhoneNumber: patientMobile,
        customerAddress: patientAddress,
        customerCity: patientUnit,
        customerPostcode: "1206",
        currency: "BDT",
      );

      // Make payment using global service
      final result = await ShurjoPayService.instance.makePayment(
        context: context,
        paymentRequest: paymentRequest,
      );

      // Handle payment result

      _handlePaymentResult(result, invoiceId, amount.toString());
    } catch (error) {
      DialogService.showErrorDialog(context, 'Payment Error', error.toString());
    } finally {
      setState(() {
        _isPaymentProcessing = false;
      });
    }
  }

  void _handlePaymentResult(
    PaymentResult result,
    String invoiceId,
    String payAmt,
  ) {
    if (result.isSuccess) {
      payBillController.payOpdBill(
        invoiceId: invoiceId,
        payAmt: payAmt.toString(),
        orderId: result.orderID,
        onSuccess: () {
          payBillController.getRegNo(
            payBillController.selectedPatient.personalNumber,
            isIPD: true,
            onSuccess: () {
              DialogService.showSuccessDialog(context, result);
            },
          );
        },
      );
    } else {
      DialogService.showErrorDialog(
        context,
        'Payment Failed',
        result.message ?? 'Unknown error occurred',
      );
    }
  }

  // Helper method for building bill rows (you'll need to implement this)
  Widget _buildBillRow(
    String label,
    String value, {
    bool isTotal = false,
    bool isDiscount = false,
    bool isPaid = false,
    bool isDue = false,
  }) {
    Color textColor = Colors.black87;
    FontWeight fontWeight = FontWeight.normal;

    if (isTotal) {
      textColor = Colors.blue;
      fontWeight = FontWeight.bold;
    } else if (isDiscount) {
      textColor = Colors.green;
    } else if (isPaid) {
      textColor = Colors.orange;
    } else if (isDue) {
      textColor = Colors.red;
      fontWeight = FontWeight.bold;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: textColor, fontWeight: fontWeight),
        ),
        Text(
          value,
          style: TextStyle(color: textColor, fontWeight: fontWeight),
        ),
      ],
    );
  }
}
