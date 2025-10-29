import 'package:flutter/material.dart';
import 'package:shurjopay/models/config.dart';
import 'package:shurjopay/models/payment_verification_model.dart';
import 'package:shurjopay/models/shurjopay_request_model.dart';
import 'package:shurjopay/models/shurjopay_response_model.dart';
import 'package:shurjopay/shurjopay.dart';

enum PaymentEnvironment {
  sandbox,
  production,
}

class PaymentCredentials {
  final String prefix;
  final String userName;
  final String password;
  final String clientIP;
  final String returnURL;
  final String cancelURL;

  const PaymentCredentials({
    required this.prefix,
    required this.userName,
    required this.password,
    required this.clientIP,
    required this.returnURL,
    required this.cancelURL,
  });
}

class PaymentRequest {
  final double amount;
  final String orderID;
  final String customerName;
  final String customerPhoneNumber;
  final String customerAddress;
  final String customerCity;
  final String customerPostcode;
  final String currency;

  const PaymentRequest({
    required this.amount,
    required this.orderID,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.customerAddress,
    required this.customerCity,
    this.customerPostcode = "",
    this.currency = "BDT",
  });
}

class PaymentResult {
  final bool isSuccess;
  final String? message;
  final String? orderID;
  final String? spCode;
  final String? spMessage;
  final ShurjopayResponseModel? responseModel;
  final ShurjopayVerificationModel? verificationModel;

  const PaymentResult({
    required this.isSuccess,
    this.message,
    this.orderID,
    this.spCode,
    this.spMessage,
    this.responseModel,
    this.verificationModel,
  });
}

class ShurjoPayService {
  static ShurjoPayService? _instance;
  static ShurjoPayService get instance =>
      _instance ??= ShurjoPayService._internal();

  ShurjoPayService._internal();

  late PaymentEnvironment _currentEnvironment;
  late PaymentCredentials _sandboxCredentials;
  late PaymentCredentials _productionCredentials;
  late ShurjoPay _shurjoPay;

  // Initialize the service with credentials
  void initialize({
    PaymentEnvironment environment = PaymentEnvironment.sandbox,
    required PaymentCredentials sandboxCredentials,
    required PaymentCredentials productionCredentials,
  }) {
    _currentEnvironment = environment;
    _sandboxCredentials = sandboxCredentials;
    _productionCredentials = productionCredentials;
    _shurjoPay = ShurjoPay();
  }

  // Get current credentials based on environment
  PaymentCredentials get _currentCredentials {
    return _currentEnvironment == PaymentEnvironment.sandbox
        ? _sandboxCredentials
        : _productionCredentials;
  }

  // Get current configs
  ShurjopayConfigs get _currentConfigs {
    final credentials = _currentCredentials;
    return ShurjopayConfigs(
      prefix: credentials.prefix,
      userName: credentials.userName,
      password: credentials.password,
      clientIP: credentials.clientIP,
    );
  }

  // Switch between environments
  void setEnvironment(PaymentEnvironment environment) {
    _currentEnvironment = environment;
  }

  // Get current environment
  PaymentEnvironment get currentEnvironment => _currentEnvironment;

  // Check if service is initialized
  bool get isInitialized => _instance != null;

  // Make payment
  Future<PaymentResult> makePayment({
    required BuildContext context,
    required PaymentRequest paymentRequest,
  }) async {
    try {
      final credentials = _currentCredentials;

      final shurjopayRequestModel = ShurjopayRequestModel(
        configs: _currentConfigs,
        currency: paymentRequest.currency,
        amount: paymentRequest.amount,
        orderID: paymentRequest.orderID,
        customerName: paymentRequest.customerName,
        customerPhoneNumber: paymentRequest.customerPhoneNumber,
        customerAddress: paymentRequest.customerAddress,
        customerCity: paymentRequest.customerCity,
        customerPostcode: paymentRequest.customerPostcode,
        returnURL: credentials.returnURL,
        cancelURL: credentials.cancelURL,
      );

      final responseModel = await _shurjoPay.makePayment(
        context: context,
        shurjopayRequestModel: shurjopayRequestModel,
      );

      if (responseModel.status == true) {
        // Verify payment
        final verificationResult = await verifyPayment(
          orderID: responseModel.shurjopayOrderID!,
        );

        return PaymentResult(
          isSuccess: verificationResult.isSuccess,
          message: verificationResult.message,
          orderID: responseModel.shurjopayOrderID,
          spCode: verificationResult.spCode,
          spMessage: verificationResult.spMessage,
          responseModel: responseModel,
          verificationModel: verificationResult.verificationModel,
        );
      } else {
        return PaymentResult(
          isSuccess: false,
          message: 'Payment failed',
          responseModel: responseModel,
        );
      }
    } catch (error) {
      return PaymentResult(
        isSuccess: false,
        message: 'Payment error: ${error.toString()}',
      );
    }
  }

  // Verify payment
  Future<PaymentResult> verifyPayment({required String orderID}) async {
    try {
      final verificationModel =
          await _shurjoPay.verifyPayment(orderID: orderID);

      final isVerified = verificationModel.spCode == "1000";

      return PaymentResult(
        isSuccess: isVerified,
        message: isVerified
            ? 'Payment verified successfully'
            : 'Payment verification failed',
        orderID: orderID,
        spCode: verificationModel.spCode,
        spMessage: verificationModel.spMessage,
        verificationModel: verificationModel,
      );
    } catch (error) {
      return PaymentResult(
        isSuccess: false,
        message: 'Verification error: ${error.toString()}',
        orderID: orderID,
      );
    }
  }

  // Generate unique order ID
  String generateOrderID({String prefix = "sp"}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return "${prefix}_${timestamp}";
  }

  // Get environment info for debugging
  String get environmentInfo {
    final env = _currentEnvironment == PaymentEnvironment.sandbox
        ? "Sandbox"
        : "Production";
    final credentials = _currentCredentials;
    return "Environment: $env\nPrefix: ${credentials.prefix}\nUsername: ${credentials.userName}";
  }
}

// Extension for easy access
extension ShurjoPayServiceExtension on ShurjoPayService {
  // Quick payment method with minimal parameters
  Future<PaymentResult> quickPayment({
    required BuildContext context,
    required double amount,
    required String customerName,
    required String customerPhone,
    String? orderID,
    String currency = "BDT",
  }) async {
    final paymentRequest = PaymentRequest(
      amount: amount,
      orderID: orderID ?? generateOrderID(),
      customerName: customerName,
      customerPhoneNumber: customerPhone,
      customerAddress: "Dhaka",
      customerCity: "Dhaka",
      currency: currency,
    );

    return makePayment(
      context: context,
      paymentRequest: paymentRequest,
    );
  }
}

// Configuration helper class
class ShurjoPayConfig {
  // Default sandbox credentials
  static const PaymentCredentials defaultSandboxCredentials =
      PaymentCredentials(
    prefix: "NOK",
    userName: "sp_sandbox",
    password: "pyyk97hu&6u6",
    clientIP: "127.0.0.1",
    returnURL: "https://www.sandbox.shurjopayment.com/return_url",
    cancelURL: "https://www.sandbox.shurjopayment.com/cancel_url",
  );

  // Default production credentials (replace with actual values)
  static const PaymentCredentials defaultProductionCredentials =
      PaymentCredentials(
    prefix: "CMHD",
    userName: "cmh_dhaka",
    password: "cmh_m9wnzbjc6ss&",
    clientIP: "127.0.0.1",
    returnURL: "https://www.engine.shurjopayment.com/return_url",
    cancelURL: "https://www.engine.shurjopayment.com/cancel_url",
  );

  // Initialize with default credentials
  static void initializeDefault({
    PaymentEnvironment environment = PaymentEnvironment.production,
    PaymentCredentials? customSandboxCredentials,
    PaymentCredentials? customProductionCredentials,
  }) {
    ShurjoPayService.instance.initialize(
      environment: environment,
      sandboxCredentials: customSandboxCredentials ?? defaultSandboxCredentials,
      productionCredentials:
          customProductionCredentials ?? defaultProductionCredentials,
    );
  }
}
