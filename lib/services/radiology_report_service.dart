import 'dart:convert';
import 'dart:typed_data';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:my_cmh_updated/config/app_config.dart';
import 'package:my_cmh_updated/services/urls.dart';

class RadiologyReportService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 160),
      receiveTimeout: const Duration(seconds: 160),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(ChuckerDioInterceptor());

  String? url;
  static final String baseUrl = AppConfig.apiUrl;

  Future<Uint8List?> fetchRadiologyReport({
    required String invoiceNo,
    required String itemNo,
  }) async {
    url = baseUrl + emrRadiologyReport;

    AppLogger.info('Request URL: $url', tag: 'RadiologyReportService');

    final requestBody = {'invoiceNo': invoiceNo, 'itemNo': itemNo};

    AppLogger.debug(
      'Request Body: ${jsonEncode(requestBody)}',
      tag: 'RadiologyReportService',
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
        tag: 'RadiologyReportService',
      );

      if (response.statusCode == 200) {
        return Uint8List.fromList(response.data);
      } else {
        AppLogger.error(
          'Failed to load PDF. Status: ${response.statusCode}',
          tag: 'RadiologyReportService',
        );
        throw Exception('Failed to load PDF. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'RadiologyReportService',
      );
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'RadiologyReportService');
      throw Exception('Error: ${e.toString()}');
    }
  }
}
