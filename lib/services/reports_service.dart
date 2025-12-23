import 'dart:convert';
import 'dart:typed_data';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:my_cmh_updated/config/app_config.dart';
import 'package:my_cmh_updated/model-new/care_of_request.dart';
import 'package:my_cmh_updated/model-new/care_of_response.dart';
import 'package:my_cmh_updated/model-new/emr_investigation_list_response.dart';
import 'package:my_cmh_updated/model-new/emr_lab_report_response.dart';
import 'package:my_cmh_updated/model-new/emr_radiology_list_response.dart';
import 'package:my_cmh_updated/model-new/investigation_report_request.dart';
import 'package:my_cmh_updated/model-new/investigation_report_request_list.dart';
import 'package:my_cmh_updated/services/urls.dart';

class ReportsService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 160),
      receiveTimeout: const Duration(seconds: 160),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(ChuckerDioInterceptor());

  String? url;
  static final String baseUrl = AppConfig.apiUrl;

  /// Fetch investigation (lab) report list
  Future<EmrInvestigationListResponse> getInvestigationReportList(
    InvestigationReportListRequest req,
  ) async {
    url = baseUrl + emrInvestigationList;

    AppLogger.info('Request URL: $url', tag: 'ReportsService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'ReportsService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug('Response: ${response.data}', tag: 'ReportsService');

      return EmrInvestigationListResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'ReportsService',
      );
      if (e.response != null) {
        return EmrInvestigationListResponse.fromJson(e.response!.data);
      } else {
        return EmrInvestigationListResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'ReportsService');
      return EmrInvestigationListResponse();
    }
  }

  /// Fetch radiology report list
  Future<EmrRadiologyReportListResponse> getRadiologyReportList(
    String hospitalID,
  ) async {
    url = baseUrl + 'emr-radiology-investigation-list?hnNumber=$hospitalID';

    AppLogger.info('Request URL: $url', tag: 'ReportsService');

    try {
      Response response = await _dio.get(url!);

      AppLogger.debug('Response: ${response.data}', tag: 'ReportsService');

      return EmrRadiologyReportListResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'ReportsService',
      );
      if (e.response != null) {
        return EmrRadiologyReportListResponse.fromJson(e.response!.data);
      } else {
        return EmrRadiologyReportListResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'ReportsService');
      return EmrRadiologyReportListResponse();
    }
  }

  /// Fetch lab report data (Base64 PDF)
  Future<EmrLabReportResponse> getLabReport(
    InvestigationReportRequest req,
  ) async {
    url = baseUrl + emrLabReport;

    AppLogger.info('Request URL: $url', tag: 'ReportsService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'ReportsService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug('Response: ${response.data}', tag: 'ReportsService');

      return EmrLabReportResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'ReportsService',
      );
      if (e.response != null) {
        return EmrLabReportResponse.fromJson(e.response!.data);
      } else {
        return EmrLabReportResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'ReportsService');
      return EmrLabReportResponse();
    }
  }

  /// Fetch patient care information
  Future<CareOfResponse> getCareOfInfo(CareOfRequest req) async {
    url = baseUrl + userInfoWithBA;

    AppLogger.info('Request URL: $url', tag: 'ReportsService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'ReportsService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug('Response: ${response.data}', tag: 'ReportsService');

      return CareOfResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'ReportsService',
      );
      if (e.response != null) {
        return CareOfResponse.fromJson(e.response!.data);
      } else {
        return CareOfResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'ReportsService');
      return CareOfResponse();
    }
  }

  Future<Uint8List?> fetchCmhLabReport({
    required String itemId,
    required int stampNo,
  }) async {
    url = baseUrl + reportPreviewCMHLab;

    AppLogger.info('Request URL: $url', tag: 'CMHLabReportService');

    final requestBody = {'itemId': itemId, 'stampNo': stampNo};

    AppLogger.debug(
      'Request Body: ${jsonEncode(requestBody)}',
      tag: 'CMHLabReportService',
    );

    try {
      Response response = await _dio.post(
        url!,
        data: jsonEncode(requestBody),
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        ),
      );

      AppLogger.debug(
        'Response Status: ${response.statusCode}',
        tag: 'CMHLabReportService',
      );

      if (response.statusCode == 200) {
        return Uint8List.fromList(response.data);
      } else {
        AppLogger.error(
          'Failed to load PDF. Status: ${response.statusCode}',
          tag: 'CMHLabReportService',
        );
        throw Exception('Failed to load PDF. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'CMHLabReportService',
      );
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'CMHLabReportService');
      throw Exception('Error: ${e.toString()}');
    }
  }
}
