import 'package:flutter/material.dart';
import 'package:my_cmh_updated/ui/payment/widget/pay_status_button.dart';

// Model class for payment result
class InitPaymentResult {
  final String paymentType;
  final double? customAmount;

  InitPaymentResult({required this.paymentType, this.customAmount});
}

// Reusable Payment Bottom Sheet Widget
class PaymentOptionsBottomSheet extends StatefulWidget {
  final Function(InitPaymentResult)? onPaymentConfirmed;
  final double? fullAmount;
  final String? currency;

  const PaymentOptionsBottomSheet({
    Key? key,
    this.onPaymentConfirmed,
    this.fullAmount,
    this.currency = '\$',
  }) : super(key: key);

  @override
  _PaymentOptionsBottomSheetState createState() =>
      _PaymentOptionsBottomSheetState();

  // Static method to show the bottom sheet
  static Future<InitPaymentResult?> show(
    BuildContext context, {
    Function(InitPaymentResult)? onPaymentConfirmed,
    double? fullAmount,
    String? currency,
  }) {
    return showModalBottomSheet<InitPaymentResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentOptionsBottomSheet(
        onPaymentConfirmed: onPaymentConfirmed,
        fullAmount: fullAmount,
        currency: currency,
      ),
    );
  }
}

class _PaymentOptionsBottomSheetState extends State<PaymentOptionsBottomSheet> {
  String selectedPaymentOption = 'full';
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _handleConfirmPayment() {
    if (selectedPaymentOption == 'custom') {
      if (!_formKey.currentState!.validate()) {
        return;
      }
    }

    final result = InitPaymentResult(
      paymentType: selectedPaymentOption,
      customAmount: selectedPaymentOption == 'custom'
          ? double.tryParse(amountController.text)
          : null,
    );

    widget.onPaymentConfirmed?.call(result);
    Navigator.pop(context, result);
  }

  String? _validateAmount(String? value) {
    if (selectedPaymentOption == 'custom') {
      if (value == null || value.isEmpty) {
        return 'Please enter an amount';
      }
      final amount = double.tryParse(value);
      if (amount == null || amount <= 0) {
        return 'Please enter a valid amount';
      }

      // Check if custom amount is greater than full amount
      if (widget.fullAmount != null && amount > widget.fullAmount!) {
        return 'Amount cannot be greater than ${widget.currency}${widget.fullAmount!.toStringAsFixed(2)}';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.45,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHandleBar(),
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(child: _buildPaymentOptions()),
              ),
              _buildConfirmButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      height: 4,
      width: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFDDE0E3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Payment Options',
          style: const TextStyle(
            color: Color(0xFF121416),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            height: 1.2,
            letterSpacing: -0.015,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildPaymentOptionTile(
            value: 'full',
            title: widget.fullAmount != null
                ? 'Pay Full Amount (${widget.fullAmount!.toStringAsFixed(2)} ${widget.currency})'
                : 'Pay Full Amount',
          ),
          const SizedBox(height: 12),
          _buildPaymentOptionTile(value: 'custom', title: 'Pay Custom Amount'),
          const SizedBox(height: 12),
          _buildCustomAmountField(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPaymentOptionTile({
    required String value,
    required String title,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDE0E3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: selectedPaymentOption,
        onChanged: (newValue) {
          setState(() {
            selectedPaymentOption = newValue!;
            if (newValue == 'full') {
              amountController.clear();
            }
          });
        },
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF121416),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        activeColor: const Color(0xFF121416),
      ),
    );
  }

  Widget _buildCustomAmountField() {
    return AnimatedOpacity(
      opacity: selectedPaymentOption == 'custom' ? 1.0 : 0,
      duration: const Duration(milliseconds: 200),
      child: TextFormField(
        controller: amountController,
        enabled: selectedPaymentOption == 'custom',
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: _validateAmount,
        style: const TextStyle(
          color: Color(0xFF121416),
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          hintText: 'Enter Amount',
          suffixText: widget.currency,
          prefixStyle: const TextStyle(color: Color(0xFF121416), fontSize: 16),
          hintStyle: const TextStyle(color: Color(0xFF6A7581), fontSize: 16),
          filled: true,
          fillColor: const Color(0xFFF1F2F4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: PaidButton(dueAmount: 20, onTap: _handleConfirmPayment),
    );
  }
}
