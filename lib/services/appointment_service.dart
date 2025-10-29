import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:smooth_chucker/smooth_chucker.dart';
import 'package:my_cmh_updated/config/app_config.dart';
import 'package:my_cmh_updated/model-new/appointment_list_response.dart';
import 'package:my_cmh_updated/model-new/cancel_appt_request.dart';
import 'package:my_cmh_updated/model-new/department_list_response_model.dart';
import 'package:my_cmh_updated/model-new/appointment_request.dart';
import 'package:my_cmh_updated/model-new/care_of_request.dart';
import 'package:my_cmh_updated/model-new/care_of_response.dart';
import 'package:my_cmh_updated/model-new/create_appointment_response.dart';
import 'package:my_cmh_updated/model-new/get_appointment_request.dart';
import 'package:my_cmh_updated/model-new/global_submit_response.dart';
import 'package:my_cmh_updated/model-new/room_list_request.dart';
import 'package:my_cmh_updated/model-new/room_list_response_model.dart';
import 'package:my_cmh_updated/model-new/time_slot_list_response_model.dart';
import 'package:my_cmh_updated/model-new/time_slot_request.dart';
import 'package:my_cmh_updated/services/urls.dart';
import 'package:my_cmh_updated/model-new/department_list_response_model.dart';

class AppointmentNetworkService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(SmoothChuckerDioInterceptor());

  String? url;
  static final String baseUrl = AppConfig.apiUrl;

  Future<DepartmentListResponseModel> getDptList() async {
    url = baseUrl + findOnlineDepartments;

    AppLogger.info('Request URL: $url', tag: 'AppointmentNetworkService');

    try {
      Response response = await _dio.post(url!);

      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'AppointmentNetworkService',
      );

      return DepartmentListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AppointmentNetworkService',
      );
      if (e.response != null) {
        return DepartmentListResponseModel.fromJson(e.response!.data);
      } else {
        return DepartmentListResponseModel();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AppointmentNetworkService');
      return DepartmentListResponseModel();
    }
  }

  Future<CareOfResponse> getCareOf(CareOfRequest req) async {
    url = baseUrl + userInfoWithBA;

    AppLogger.info('Request URL: $url', tag: 'AppointmentNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req)}',
      tag: 'AppointmentNetworkService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'AppointmentNetworkService',
      );

      return CareOfResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AppointmentNetworkService',
      );

      if (e.response != null) {
        return CareOfResponse.fromJson(e.response!.data);
      } else {
        return CareOfResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AppointmentNetworkService');
      return CareOfResponse();
    }
  }

  Future<RoomListResponseModel> getRoomList(RoomListRequest req) async {
    url = baseUrl + roomList;

    AppLogger.info('Request URL: $url', tag: 'AppointmentNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req)}',
      tag: 'AppointmentNetworkService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'AppointmentNetworkService',
      );

      return RoomListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AppointmentNetworkService',
      );

      if (e.response != null) {
        return RoomListResponseModel.fromJson(e.response!.data);
      } else {
        return RoomListResponseModel();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AppointmentNetworkService');
      return RoomListResponseModel();
    }
  }

  Future<TimeSlotListResponseModel> getTimeSlotPerRoom(
    TimeSlotRequest req,
  ) async {
    url = baseUrl + timeSlotperRoom;

    AppLogger.info('Request URL: $url', tag: 'AppointmentNetworkService');
    AppLogger.debug(
      'Request Body: ${jsonEncode(req)}',
      tag: 'AppointmentNetworkService',
    );

    try {
      Response response = await _dio.post(url!, data: jsonEncode(req.toJson()));

      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'AppointmentNetworkService',
      );

      return TimeSlotListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AppointmentNetworkService',
      );

      if (e.response != null) {
        return TimeSlotListResponseModel.fromJson(e.response!.data);
      } else {
        return TimeSlotListResponseModel();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AppointmentNetworkService');
      return TimeSlotListResponseModel();
    }
  }

  Future<GlobalSubmitResponse> callApiRetainSlotSl(String slotNo) async {
    url = baseUrl + retainSlot;
    AppLogger.info('Request URL: $url', tag: 'AppointmentNetworkService');

    try {
      Response response = await _dio.post(
        url!, // Ensure retainSlot is defined
        data: {'slotNo': slotNo}, // Sending form data
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'AppointmentNetworkService',
      );

      if (response.statusCode == 200) {
        return GlobalSubmitResponse.fromJson(response.data);
      } else {
        return GlobalSubmitResponse();
      }
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AppointmentNetworkService',
      );

      if (e.response != null) {
        return GlobalSubmitResponse.fromJson(e.response!.data);
      } else {
        return GlobalSubmitResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AppointmentNetworkService');
      return GlobalSubmitResponse();
    }
  }

  Future<GlobalSubmitResponse> callApiReleaseSlotSl(String slotNo) async {
    url = baseUrl + releaseSlot;
    AppLogger.info('Request URL: $url', tag: 'AppointmentNetworkService');

    try {
      Response response = await _dio.post(
        url!, // Ensure retainSlot is defined
        data: {'slotNo': slotNo}, // Sending form data
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      AppLogger.debug(
        'Response: ${response.data}',
        tag: 'AppointmentNetworkService',
      );

      if (response.statusCode == 200) {
        return GlobalSubmitResponse.fromJson(response.data);
      } else {
        return GlobalSubmitResponse();
      }
    } on DioException catch (e) {
      AppLogger.error(
        'Dio Error: ${e.response?.data ?? e.message}',
        tag: 'AppointmentNetworkService',
      );

      if (e.response != null) {
        return GlobalSubmitResponse.fromJson(e.response!.data);
      } else {
        return GlobalSubmitResponse();
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AppointmentNetworkService');
      return GlobalSubmitResponse();
    }
  }

  Future<CreateAppointmentResponse> createAppointment(
    AppointmentRequest req,
  ) async {
    url = baseUrl + createAppontment;
    try {
      AppLogger.info('Request URL: $url', tag: 'AppointmentNetworkService');
      AppLogger.debug(
        'Request Body: ${req.toJson()}',
        tag: 'AppointmentNetworkService',
      );
      final response = await _dio.post(url!, data: req.toJson());

      if (response.statusCode == 200) {
        return CreateAppointmentResponse.fromJson(response.data);
      } else {
        return CreateAppointmentResponse(
          success: false,
          message: "Request failed",
        );
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AppointmentNetworkService');
      return CreateAppointmentResponse(success: false, message: e.toString());
    }
  }

  Future<GlobalSubmitResponse> cancelAppointments(CancelRequest req) async {
    url = baseUrl + cancelAppointment;
    try {
      AppLogger.info('Request URL: $url', tag: 'AppointmentNetworkService');
      AppLogger.debug(
        'Request Body: ${req.toJson()}',
        tag: 'AppointmentNetworkService',
      );
      final response = await _dio.post(url!, data: req.toJson());

      if (response.statusCode == 200) {
        AppLogger.debug(
          'Response: ${response.data}',
          tag: 'AppointmentNetworkService',
        );
        return GlobalSubmitResponse.fromJson(response.data);
      } else {
        return GlobalSubmitResponse(success: false, message: "Request failed");
      }
    } catch (e) {
      AppLogger.error('Unexpected Error: $e', tag: 'AppointmentNetworkService');
      return GlobalSubmitResponse(success: false, message: e.toString());
    }
  }

  Future<AppointmentListResponse> getAppointmentListNew(
    GetAppointmentRequest req,
  ) async {
    url = baseUrl + allAppontment;
    AppLogger.info('Request URL: $url', tag: 'AppointmentNetworkService');
    try {
      final response = await _dio.post(url!, data: req.toJson());
      if (response.statusCode == 200 || response.statusCode == 400) {
        AppLogger.debug(
          'Response: ${response.data}',
          tag: 'AppointmentNetworkService',
        );
        Map<String, dynamic> map;
        if (response.data is String) {
          map = jsonDecode(response.data);
        } else if (response.data is Map<String, dynamic>) {
          map = response.data;
        } else {
          return AppointmentListResponse();
        }
        return AppointmentListResponse.fromJson(map);
      } else {
        return AppointmentListResponse();
      }
    } catch (e) {
      AppLogger.error(
        'Error in getAppointmentListNew: $e',
        tag: 'AppointmentNetworkService',
      );
      return AppointmentListResponse();
    }
  }
}
