import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_cmh_updated/config/app_config.dart';
import 'package:my_cmh_updated/model-new/appointment_list_response.dart';
import 'package:my_cmh_updated/model-new/appointment_lookup_response.dart';
import 'package:my_cmh_updated/model-new/cancel_appt_request.dart';
import 'package:my_cmh_updated/model-new/emr_investigation_list_response.dart';
import 'package:my_cmh_updated/model-new/emr_lab_report_response.dart';
import 'package:my_cmh_updated/model-new/emr_radiology_list_response.dart';
import 'package:my_cmh_updated/model-new/emr_radiology_report_data_response.dart';
import 'package:my_cmh_updated/model-new/feedback_request.dart';
import 'package:my_cmh_updated/model-new/global_submit_response.dart';
import 'package:my_cmh_updated/model-new/care_of_request.dart';
import 'package:my_cmh_updated/model-new/care_of_response.dart';
import 'package:my_cmh_updated/model-new/get_appointment_request.dart';
import 'package:my_cmh_updated/model-new/investigation_report_request.dart';
import 'package:my_cmh_updated/model-new/investigation_report_request_list.dart';
import 'package:my_cmh_updated/model-new/misc_info_response_model.dart';
import 'package:my_cmh_updated/model-new/otp_verify_request.dart';
import 'package:my_cmh_updated/model-new/password_change_request.dart';
import 'package:my_cmh_updated/model-new/prescription_layout_response.dart';
import 'package:my_cmh_updated/model-new/prescription_list_response.dart';
import 'package:my_cmh_updated/model-new/reg_request.dart';
import 'package:my_cmh_updated/model-new/reg_response.dart';
import 'package:my_cmh_updated/model-new/remove_account_request.dart';
import 'package:my_cmh_updated/services/urls.dart';

class NetworkHelper {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };
  Duration timeoutDuration = Duration(seconds: 60);

  Map<String, String> requestHeadersUpdate = {
    'Content-type': 'application/x-www-form-urlencoded',
    'Authorization':
        'Basic b25saW5lTXlBcHBDbGllbnRQYXNzd29yZDpvbmxpbmVNeWFwcDc4Njc4Ng==',
  };
  String? url;
  static final String baseUrl = AppConfig.apiUrl;

  Future<RegResponse> registerUserNew(RegRequest req) async {
    url = baseUrl + registration;
    AppLogger.info('URL: $url');

    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };
    AppLogger.debug('Request body: ${jsonEncode(req.toJson())}');

    try {
      Response response = await post(
        Uri.parse(url!),
        headers: requestHeadersWithAuth,
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        AppLogger.info('Response body: ${response.body}');
        try {
          String data = response.body;
          Map<String, dynamic> map = jsonDecode(data);
          var dataModel = RegResponse.fromJson(map);

          return dataModel;
        } catch (e) {
          return RegResponse();
        }
      } else if (response.statusCode == 400) {
        AppLogger.info('Response body: ${response.body}');

        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = RegResponse.fromJson(map);

        return dataModel;
      } else {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        AppLogger.error('Response body: $map');
        var dataModel = RegResponse.fromJson(map);

        return dataModel;
      }
    } catch (e) {
      return RegResponse();
    }
  }

  Future<GlobalSubmitResponse> submitFeedback(FeedbackRequest req) async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };
    url = baseUrl + feedBack;
    AppLogger.info('URL: $url');
    AppLogger.debug('Request body: ${jsonEncode(req.toJson())}');
    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = GlobalSubmitResponse.fromJson(map);

        return dataModel;
      } catch (e) {
        return GlobalSubmitResponse();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = GlobalSubmitResponse.fromJson(map);

      return dataModel;
    } else {
      var dataModel = GlobalSubmitResponse();
      return dataModel;
    }
  }

  Future<EmrInvestigationListResponse> getInvestigationReportList(
    InvestigationReportListRequest req,
  ) async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };
    url = baseUrl + emrInvestigationList;
    AppLogger.info('URL: $url');
    AppLogger.debug('Request body: ${jsonEncode(req.toJson())}');

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = EmrInvestigationListResponse.fromJson(map);

        return dataModel;
      } catch (e) {
        return EmrInvestigationListResponse();
      }
    } else if (response.statusCode == 400) {
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = EmrInvestigationListResponse.fromJson(map);

      return dataModel;
    } else {
      var dataModel = EmrInvestigationListResponse();
      return dataModel;
    }
  }

  Future<EmrLabReportResponse> getInvestigationRepor(
    InvestigationReportRequest req,
  ) async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };
    url = baseUrl + emrLabReport;
    AppLogger.info('URL: $url');
    AppLogger.debug('Request body: ${jsonEncode(req.toJson())}');
    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = EmrLabReportResponse.fromJson(map);

        return dataModel;
      } catch (e) {
        return EmrLabReportResponse();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = EmrLabReportResponse.fromJson(map);

      return dataModel;
    } else {
      var dataModel = EmrLabReportResponse();
      return dataModel;
    }
  }

  Future<EmrRadiologyReportListResponse> getRadiologyReportList(
    String hospitalID,
  ) async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };
    url = baseUrl + 'emr-radiology-investigation-list?hnNumber=$hospitalID';
    AppLogger.info('URL: $url');

    Response response = await get(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');
      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = EmrRadiologyReportListResponse.fromJson(map);

        return dataModel;
      } catch (e) {
        return EmrRadiologyReportListResponse();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = EmrRadiologyReportListResponse.fromJson(map);

      return dataModel;
    } else {
      var dataModel = EmrRadiologyReportListResponse();
      return dataModel;
    }
  }

  Future<EmrRadiologyReportDataResponse> getRadiologyReportData(
    String invoice,
    String itemNo,
  ) async {
    url =
        baseUrl + 'emr-radiology-report-data?invoiceNo=$invoice&itemNo=$itemNo';
    AppLogger.info('URL: $url');
    Response response = await get(Uri.parse(url!));
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');
      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = EmrRadiologyReportDataResponse.fromJson(map);

        return dataModel;
      } catch (e) {
        return EmrRadiologyReportDataResponse();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = EmrRadiologyReportDataResponse.fromJson(map);

      return dataModel;
    } else {
      var dataModel = EmrRadiologyReportDataResponse();
      return dataModel;
    }
  }

  //emr-radiology-report-data?invoiceNo=1230004886329&itemNo=101449

  Future<PrescriptionListResponse> getPrescription(
    String hospitalID,
    String fromDate,
    String toDate,
  ) async {
    url =
        baseUrl +
        'emr-prescription-list?hospitalId=$hospitalID&fromDate=$fromDate&toDate=$toDate';
    AppLogger.info('URL: $url');
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    Response response = await get(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
    );

    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = PrescriptionListResponse.fromJson(map);

        return dataModel;
      } catch (e) {
        return PrescriptionListResponse();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');

      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = PrescriptionListResponse.fromJson(map);

      return dataModel;
    } else {
      return PrescriptionListResponse();
    }
  }

  Future<PrescriptionLayoutResponse> getPrescriptionLayout(
    String doctorNo,
  ) async {
    url = baseUrl + 'emr-prescription-report-layout?doctorNo=$doctorNo';
    AppLogger.info('URL: $url');

    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
    );

    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = PrescriptionLayoutResponse.fromJson(map);

        return dataModel;
      } catch (e) {
        return PrescriptionLayoutResponse();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');

      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = PrescriptionLayoutResponse.fromJson(map);

      return dataModel;
    } else {
      return PrescriptionLayoutResponse();
    }
  }

  Future<AppointmentLookupDetailListResponse> getAppointmentLookUp() async {
    url = baseUrl + periorityList;
    AppLogger.info('URL: $url');
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
    );

    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = AppointmentLookupDetailListResponse.fromJson(map);

        return dataModel;
      } catch (e) {
        return AppointmentLookupDetailListResponse();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');

      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = AppointmentLookupDetailListResponse.fromJson(map);

      return dataModel;
    } else {
      return AppointmentLookupDetailListResponse();
    }
  }

  Future<CareOfResponse> getCareOf(CareOfRequest req) async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + userInfoWithBA;
    AppLogger.info('URL: $url');
    AppLogger.debug('Request body: ${jsonEncode(req.toJson())}');
    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = CareOfResponse.fromJson(map);

        return dataModel;
      } catch (e) {
        return CareOfResponse();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = CareOfResponse.fromJson(map);

      return dataModel;
    } else {
      var dataModel = CareOfResponse();
      return dataModel;
    }
  }

  Future<AppointmentListResponse> getAppointmentListNew(
    GetAppointmentRequest req,
  ) async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + allAppontment;
    AppLogger.info('URL: $url');
    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');
      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = AppointmentListResponse.fromJson(map);
        return dataModel;
      } catch (e) {
        return AppointmentListResponse();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = AppointmentListResponse.fromJson(map);
      return dataModel;
    } else {
      var dataModel = AppointmentListResponse();
      return dataModel;
    }
  }

  Future<GlobalSubmitResponse> cancelAppointments(CancelRequest req) async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + cancelAppointment;
    AppLogger.info('URL: $url');
    AppLogger.debug('Request body: ${jsonEncode(req.toJson())}');

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = GlobalSubmitResponse.fromJson(map);
        return dataModel;
      } catch (e) {
        return GlobalSubmitResponse();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = GlobalSubmitResponse.fromJson(map);
      return dataModel;
    } else {
      var dataModel = GlobalSubmitResponse();
      return dataModel;
    }
  }

  Future<GlobalSubmitResponse> passwordChange(PasswordChangeRequest req) async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + updatePassword;
    AppLogger.info('URL: $url');
    AppLogger.debug('Request body: ${jsonEncode(req.toJson())}');

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = GlobalSubmitResponse.fromJson(map);
        return dataModel;
      } catch (e) {
        return GlobalSubmitResponse();
      }
    } else if (response.statusCode == 401) {
      AppLogger.info('Response body: ${response.body}');

      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = GlobalSubmitResponse.fromJson(map);
      return dataModel;
    } else {
      var dataModel = GlobalSubmitResponse();
      return dataModel;
    }
  }

  Future<GlobalSubmitResponse> otpVerifyReq(OTPRequest req) async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + otpVerify;
    AppLogger.info('URL: $url');
    AppLogger.debug('Request body: ${jsonEncode(req.toJson())}');

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = GlobalSubmitResponse.fromJson(map);
        return dataModel;
      } catch (e) {
        return GlobalSubmitResponse();
      }
    } else if (response.statusCode == 401) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = GlobalSubmitResponse.fromJson(map);
      return dataModel;
    } else {
      var dataModel = GlobalSubmitResponse();
      return dataModel;
    }
  }

  Future<GlobalSubmitResponse> removeAccount(RemoveAccountRequest req) async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + accountRemoval;
    AppLogger.info('URL: $url');
    AppLogger.debug('Request body: ${jsonEncode(req.toJson())}');

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = GlobalSubmitResponse.fromJson(map);
        return dataModel;
      } catch (e) {
        return GlobalSubmitResponse();
      }
    } else if (response.statusCode == 401) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = GlobalSubmitResponse.fromJson(map);
      return dataModel;
    } else {
      var dataModel = GlobalSubmitResponse();
      return dataModel;
    }
  }

  Future<MiscInfoResponseModel> getInfoNijukti() async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + infoNijukti;
    AppLogger.info('URL: $url');

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = MiscInfoResponseModel.fromJson(map);
        return dataModel;
      } catch (e) {
        return MiscInfoResponseModel();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = MiscInfoResponseModel.fromJson(map);
      return dataModel;
    } else {
      var dataModel = MiscInfoResponseModel();
      return dataModel;
    }
  }

  Future<MiscInfoResponseModel> getInfoOpd() async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + infoOpd;
    AppLogger.info('URL: $url');

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = MiscInfoResponseModel.fromJson(map);
        return dataModel;
      } catch (e) {
        return MiscInfoResponseModel();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = MiscInfoResponseModel.fromJson(map);
      return dataModel;
    } else {
      var dataModel = MiscInfoResponseModel();
      return dataModel;
    }
  }

  Future<MiscInfoResponseModel> getInfoAdmin() async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + infoAdmin;
    AppLogger.info('URL: $url');

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = MiscInfoResponseModel.fromJson(map);
        return dataModel;
      } catch (e) {
        return MiscInfoResponseModel();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = MiscInfoResponseModel.fromJson(map);
      return dataModel;
    } else {
      var dataModel = MiscInfoResponseModel();
      return dataModel;
    }
  }

  Future<MiscInfoResponseModel> getInfoDoctors() async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + infoDoctors;
    AppLogger.info('URL: $url');

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = MiscInfoResponseModel.fromJson(map);
        return dataModel;
      } catch (e) {
        return MiscInfoResponseModel();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = MiscInfoResponseModel.fromJson(map);
      return dataModel;
    } else {
      var dataModel = MiscInfoResponseModel();
      return dataModel;
    }
  }

  Future<MiscInfoResponseModel> getInfoDept() async {
    Map<String, String> requestHeadersWithAuth = {
      'Content-type': 'application/json',
    };

    url = baseUrl + infoDept;
    AppLogger.info('URL: $url');

    Response response = await post(
      Uri.parse(url!),
      headers: requestHeadersWithAuth,
    );
    if (response.statusCode == 200) {
      AppLogger.info('Response body: ${response.body}');

      try {
        String data = response.body;
        Map<String, dynamic> map = jsonDecode(data);
        var dataModel = MiscInfoResponseModel.fromJson(map);
        return dataModel;
      } catch (e) {
        return MiscInfoResponseModel();
      }
    } else if (response.statusCode == 400) {
      AppLogger.info('Response body: ${response.body}');
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      var dataModel = MiscInfoResponseModel.fromJson(map);
      return dataModel;
    } else {
      var dataModel = MiscInfoResponseModel();
      return dataModel;
    }
  }
}
