import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smooth_chucker/smooth_chucker.dart';
import 'package:my_cmh_updated/config/app_config.dart';
import 'package:my_cmh_updated/model-new/app_version_response_model.dart';
import 'package:my_cmh_updated/model-new/login_request.dart';
import 'package:my_cmh_updated/model-new/login_response.dart';
import 'package:my_cmh_updated/model-new/password_change_response.dart';
import 'package:my_cmh_updated/model-new/reg_request.dart';
import 'package:my_cmh_updated/model-new/reg_response.dart';
import 'package:my_cmh_updated/model-new/user_info_response.dart';
import 'package:my_cmh_updated/model-new/user_request.dart';
import 'package:my_cmh_updated/model/login/forgot_pass_req.dart';
import 'package:my_cmh_updated/services/urls.dart';

class AuthNetworkService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(SmoothChuckerDioInterceptor());

  String? url;

  static final String baseUrl = AppConfig.apiUrl;

  Future<LoginResponse> loginUserNew(LoginRequest req) async {
    url = baseUrl + login;

    AppLogger.info('Request URL: $url', tag: 'AuthNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'AuthNetworkService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug('Response: ${response.data}', tag: 'AuthNetworkService');

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AuthNetworkService',
      );
      if (e.response != null) {
        return LoginResponse.fromJson(e.response!.data);
      } else {
        return LoginResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AuthNetworkService');
      return LoginResponse();
    }
  }

  Future<UserInfoResponse> getUserNew(UserRequest req) async {
    url = baseUrl + userInfo;

    AppLogger.info('Request URL: $url', tag: 'AuthNetworkService');

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug('Response: ${response.data}', tag: 'AuthNetworkService');

      return UserInfoResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AuthNetworkService',
      );
      if (e.response != null) {
        return UserInfoResponse.fromJson(e.response!.data);
      } else {
        return UserInfoResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AuthNetworkService');
      return UserInfoResponse();
    }
  }

  /// 🔑 Forgot Password API
  Future<PasswordChangeResponse> forgotPasswordNew(ForgotPassReq req) async {
    url = baseUrl + paswwordChange;

    AppLogger.info('Request URL: $url', tag: 'AuthNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'AuthNetworkService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug('Response: ${response.data}', tag: 'AuthNetworkService');

      return PasswordChangeResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AuthNetworkService',
      );
      if (e.response != null) {
        return PasswordChangeResponse.fromJson(e.response!.data);
      } else {
        return PasswordChangeResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AuthNetworkService');
      return PasswordChangeResponse();
    }
  }

  /// 🔑 **User Registration**
  Future<RegResponse> registerUserNew(RegRequest req) async {
    final String url = '$baseUrl$registration';

    AppLogger.info('Request URL: $url', tag: 'AuthNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req.toJson())}',
      tag: 'AuthNetworkService',
    );

    try {
      Response response = await _dio.post(url, data: jsonEncode(req.toJson()));

      AppLogger.debug('Response: ${response.data}', tag: 'AuthNetworkService');

      return RegResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AuthNetworkService',
      );
      if (e.response != null) {
        return RegResponse.fromJson(e.response!.data);
      } else {
        return RegResponse(success: false, message: e.message);
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AuthNetworkService');
      return RegResponse();
    }
  }

  Future<AppVersionResponseModel> getAndroidVersion() async {
    url = baseUrl + (Platform.isAndroid ? androidAppVersion : iOSAppVersion);

    AppLogger.info('Request URL: $url', tag: 'AuthNetworkService');

    try {
      Response response = await _dio.get(url!);

      AppLogger.debug('Response: ${response.data}', tag: 'AuthNetworkService');

      return AppVersionResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AuthNetworkService',
      );
      if (e.response != null) {
        return AppVersionResponseModel.fromJson(e.response!.data);
      } else {
        return AppVersionResponseModel();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AuthNetworkService');
      return AppVersionResponseModel();
    }
  }
}
