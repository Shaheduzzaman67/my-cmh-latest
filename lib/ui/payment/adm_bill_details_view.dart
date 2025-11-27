import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/custom_widgets/reusable_card.dart';
import 'package:my_cmh_updated/ui/payment/widget/pay_status_button.dart';
import 'package:my_cmh_updated/ui/payment/widget/payment_bottomsheet.dart';
import 'package:my_cmh_updated/utils/surjopay_util.dart';
import 'package:my_cmh_updated/utils/dialog_service.dart';

// ignore: must_be_immutable
class AdmBillDetailsView extends StatefulWidget {
  AdmBillDetailsView({Key? key}) : super(key: key);

  @override
  State<AdmBillDetailsView> createState() => _AdmBillDetailsViewState();
}

class _AdmBillDetailsViewState extends State<AdmBillDetailsView> {
  var payBillController = GetControllers.shared.payBillController();

  InitPaymentResult? lastPaymentResult;
  bool _isPaymentProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializePaymentService();
  }

  // Initialize the payment service if not already initialized
  void _initializePaymentService() {
    if (!ShurjoPayService.instance.isInitialized) {
      ShurjoPayConfig.initializeDefault(
        environment:
            PaymentEnvironment.sandbox, // Change to production when ready
      );
    }
  }

  // Handle payment with the global service
  Future<void> _handlePayment({
    required double amount,
    String? customOrderId,
  }) async {
    if (_isPaymentProcessing) return;

    setState(() {
      _isPaymentProcessing = true;
    });

    try {
      // Get patient information
      final patientName =
          payBillController
              .admissionSummery
              .value
              .model
              ?.patientInfo
              ?.patientName ??
          'Unknown Patient';

      final patientMobile =
          payBillController
              .admissionSummery
              .value
              .model
              ?.patientInfo
              ?.phoneMobile ??
          'Unknown Number';

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
      final admissionId =
          payBillController.admissionBillSummery.value.admissionNo
              ?.toString() ??
          '';
      final admissionNo =
          payBillController.admissionBillSummery.value.admissionNo ?? 0;
      // Create payment request
      final paymentRequest = PaymentRequest(
        amount: amount,
        orderID: admissionId,
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
      _handlePaymentResult(result, admissionNo, amount.toString());
    } catch (error) {
      DialogService.showErrorDialog(context, 'Payment Error', error.toString());
    } finally {
      setState(() {
        _isPaymentProcessing = false;
      });
    }
  }

  // Handle payment result
  void _handlePaymentResult(
    PaymentResult result,
    int admissionNumber,
    String payAmt,
  ) {
    if (result.isSuccess) {
      payBillController.payAdmissonBill(
        admissionNo: admissionNumber,
        payAmt: payAmt.toString(),
        orderId: result.orderID,
        remarks: 'Paid',
        onSuccess: () {
          payBillController.refreshSummery(
            admissionNumber.toString(),
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

  // Validate if phone number is a valid BD number
  bool _isValidBDPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return false;
    }

    // Remove any spaces, dashes, or special characters
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    // BD phone numbers are 11 digits starting with 01
    if (cleanedNumber.length == 11 && cleanedNumber.startsWith('01')) {
      return true;
    }

    // Also accept numbers with country code +880 or 880
    if (cleanedNumber.length == 13 && cleanedNumber.startsWith('880')) {
      return true;
    }

    return false;
  }

  void _showPaymentOptions(BuildContext context) async {
    // Get patient phone number
    final patientMobile = payBillController
        .admissionSummery
        .value
        .model
        ?.patientInfo
        ?.phoneMobile;

    // Validate phone number before proceeding
    if (!_isValidBDPhoneNumber(patientMobile)) {
      DialogService.showErrorDialog(
        context,
        'Invalid Mobile Number',
        'Please update your mobile number with a valid Bangladesh phone number before making online payment.',
      );
      return;
    }

    final result = await PaymentOptionsBottomSheet.show(
      context,
      fullAmount: payBillController.admissionBillSummery.value.dueAmt,
      currency: 'TK',
      onPaymentConfirmed: (paymentResult) async {
        // Handle the payment result from bottom sheet

        double paymentAmount;
        if (paymentResult.paymentType == 'full') {
          paymentAmount =
              payBillController.admissionBillSummery.value.dueAmt ?? 0;
        } else {
          paymentAmount = paymentResult.customAmount ?? 0;
        }

        if (paymentAmount > 0) {
          // Process payment with the selected amount
          await _handlePayment(
            amount: paymentAmount,
            customOrderId: payBillController
                .admissionBillSummery
                .value
                .admissionNo
                .toString(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Bill Details',
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: FONT_NAME,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        backgroundColor: colorAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount and Pay Now Section
            ReusableCard(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Due',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${payBillController.admissionBillSummery.value.dueAmt?.toStringAsFixed(2) ?? '0.00'} TK',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    PaidButton(
                      dueAmount:
                          payBillController.admissionBillSummery.value.dueAmt ??
                          0,
                      onTap: () => _showPaymentOptions(context),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Patient Information Section
            ReusableCard(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Patient Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInfoRow(
                      'Patient Name',
                      payBillController
                              .admissionSummery
                              .value
                              .model
                              ?.patientInfo
                              ?.patientName ??
                          'N/A',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      'Admission ID',
                      payBillController.admissionBillSummery.value.admissionNo
                              ?.toString() ??
                          'N/A',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      'Total Bill',
                      '${payBillController.admissionBillSummery.value.totalBill?.toStringAsFixed(2) ?? '0.00'} TK',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      'Total Discount',
                      '${payBillController.admissionBillSummery.value.totalDiscount?.toStringAsFixed(2) ?? '0.00'} TK',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      'Total Collection',
                      '${payBillController.admissionBillSummery.value.totalCollection?.toStringAsFixed(2) ?? '0.00'} TK',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Summary of Charges Section
            ReusableCard(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Summary of Charges',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  ListView.builder(
                    itemCount: payBillController.admissionBillList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var item = payBillController.admissionBillList[index];
                      return Column(
                        children: [
                          if (index == 0) const SizedBox(height: 20),
                          _buildChargeRow(
                            item.headName ?? '',
                            item.totalAmount.toString() + ' TK',
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildChargeRow(String description, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
