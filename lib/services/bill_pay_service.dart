import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:smooth_chucker/smooth_chucker.dart';
import 'package:my_cmh_updated/config/app_config.dart';
import 'package:my_cmh_updated/model-new/global_submit_response.dart';
import 'package:my_cmh_updated/model-new/pay_bill/admission_bill_request.dart';
import 'package:my_cmh_updated/model-new/pay_bill/admission_list_response.dart';
import 'package:my_cmh_updated/model-new/pay_bill/admission_response.dart';
import 'package:my_cmh_updated/model-new/pay_bill/admission_summery_request.dart';
import 'package:my_cmh_updated/model-new/pay_bill/invoice_list_response.dart';
import 'package:my_cmh_updated/model-new/pay_bill/opd_list_request.dart';
import 'package:my_cmh_updated/model-new/pay_bill/opd_pay_request.dart';
import 'package:my_cmh_updated/services/urls.dart';

class PayBillNetworkService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 160),
      receiveTimeout: const Duration(seconds: 160),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(SmoothChuckerDioInterceptor());

  String? url;
  static final String baseUrl = AppConfig.apiUrl;

  Future<InvoiceListResponse> opdList(OpdListRequest req) async {
    url = baseUrl + opdInvoiceList;

    AppLogger.info('Request URL: $url', tag: 'PayBillNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'PayBillNetworkService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'PayBillNetworkService',
      );

      return InvoiceListResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'PayBillNetworkService',
      );
      if (e.response != null) {
        return InvoiceListResponse.fromJson(e.response!.data);
      } else {
        return InvoiceListResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'PayBillNetworkService');
      return InvoiceListResponse();
    }
  }

  Future<AdmissionListResponse> admissionList(OpdListRequest req) async {
    url = baseUrl + admAdmissionList;

    AppLogger.info('Request URL: $url', tag: 'PayBillNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'PayBillNetworkService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'PayBillNetworkService',
      );

      return AdmissionListResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'PayBillNetworkService',
      );
      if (e.response != null) {
        return AdmissionListResponse.fromJson(e.response!.data);
      } else {
        return AdmissionListResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'PayBillNetworkService');
      return AdmissionListResponse();
    }
  }

  Future<AppointmentSummeryResponse> admissionSummery(
    AdmissionSummeryRequest req,
  ) async {
    url = baseUrl + admAdmissionSummery;

    AppLogger.info('Request URL: $url', tag: 'PayBillNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'PayBillNetworkService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'PayBillNetworkService',
      );

      return AppointmentSummeryResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'PayBillNetworkService',
      );
      if (e.response != null) {
        return AppointmentSummeryResponse.fromJson(e.response!.data);
      } else {
        return AppointmentSummeryResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'PayBillNetworkService');
      return AppointmentSummeryResponse();
    }
  }

  Future<GlobalSubmitResponse> admissionPay(AdmissionBillRequest req) async {
    url = baseUrl + admAdmissionPay;

    AppLogger.info('Request URL: $url', tag: 'PayBillNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'PayBillNetworkService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'PayBillNetworkService',
      );

      return GlobalSubmitResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'PayBillNetworkService',
      );
      if (e.response != null) {
        return GlobalSubmitResponse.fromJson(e.response!.data);
      } else {
        return GlobalSubmitResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'PayBillNetworkService');
      return GlobalSubmitResponse();
    }
  }

  Future<GlobalSubmitResponse> opdPay(OpdPayRequest req) async {
    url = baseUrl + opdInvoicePay;
    AppLogger.info('Request URL: $url', tag: 'PayBillNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'PayBillNetworkService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'PayBillNetworkService',
      );

      return GlobalSubmitResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'PayBillNetworkService',
      );
      if (e.response != null) {
        return GlobalSubmitResponse.fromJson(e.response!.data);
      } else {
        return GlobalSubmitResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'PayBillNetworkService');
      return GlobalSubmitResponse();
    }
  }
}
