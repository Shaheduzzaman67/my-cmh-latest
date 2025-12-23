import 'package:get/get.dart';
import 'package:my_cmh_updated/controller/appointment_controller.dart';
import 'package:my_cmh_updated/controller/auth_controller.dart';
import 'package:my_cmh_updated/controller/help_desk_controller.dart';
import 'package:my_cmh_updated/controller/pay_bill_controller.dart';
import 'package:my_cmh_updated/controller/radiology_report_controller.dart';
import 'package:my_cmh_updated/controller/reports_controller.dart';

class GetControllers {
  static final GetControllers _singleton = GetControllers._internal();

  factory GetControllers() {
    return _singleton;
  }

  GetControllers._internal();

  static GetControllers get shared => _singleton;

  HelpDeskController getHelpDeskController() {
    if (!Get.isRegistered<HelpDeskController>()) {
      Get.put(HelpDeskController());
    }
    return Get.find<HelpDeskController>();
  }

  AppointmentController getAppointmentController() {
    if (!Get.isRegistered<AppointmentController>()) {
      Get.put(AppointmentController());
    }
    return Get.find<AppointmentController>();
  }

  AuthController getAuthController() {
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController());
    }
    return Get.find<AuthController>();
  }

  PayBillController payBillController() {
    if (!Get.isRegistered<PayBillController>()) {
      Get.put(PayBillController());
    }
    return Get.find<PayBillController>();
  }

  RadiologyReportController getRadiologyReportController() {
    if (!Get.isRegistered<RadiologyReportController>()) {
      Get.put(RadiologyReportController());
    }
    return Get.find<RadiologyReportController>();
  }

  ReportsController getReportsController() {
    if (!Get.isRegistered<ReportsController>()) {
      Get.put(ReportsController());
    }
    return Get.find<ReportsController>();
  }
}
