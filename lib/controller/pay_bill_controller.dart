import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/model-new/care_of_request.dart';
import 'package:my_cmh_updated/model-new/global_submit_response.dart';
import 'package:my_cmh_updated/model-new/pay_bill/admission_bill_request.dart';
import 'package:my_cmh_updated/model-new/pay_bill/admission_list_response.dart';
import 'package:my_cmh_updated/model-new/pay_bill/admission_response.dart';
import 'package:my_cmh_updated/model-new/pay_bill/admission_summery_request.dart';
import 'package:my_cmh_updated/model-new/pay_bill/invoice_list_response.dart';
import 'package:my_cmh_updated/model-new/pay_bill/opd_list_request.dart';
import 'package:my_cmh_updated/model-new/pay_bill/opd_pay_request.dart';
import 'package:my_cmh_updated/services/appointment_service.dart';
import 'package:my_cmh_updated/model-new/care_of_response.dart' as careOf;

import 'package:my_cmh_updated/services/bill_pay_service.dart';
import 'package:my_cmh_updated/ui/payment/adm_bill_details_view.dart';
import 'package:my_cmh_updated/utils/loading_utils.dart';

class PayBillController extends GetxController {
  final PayBillNetworkService _networkHelper = PayBillNetworkService();
  final AppointmentNetworkService _appointmentService =
      AppointmentNetworkService();

  var selectedPatient;
  final RxList<InvoiceItem> opdList = <InvoiceItem>[].obs;

  final RxList<AdmissionItem> admissionList = <AdmissionItem>[].obs;
  var careOfPaientInfo = careOf.Info().obs;

  var admissionSummery = AppointmentSummeryResponse().obs;
  var admissionBillList = <HeadWiseTotalBill>[].obs;
  var admissionBillSummery = BillSummary().obs;

  Future<void> getOpdList(String reglNumber) async {
    admissionList.clear();
    opdList.clear();
    LoadingUtils().showLoading();

    var req = OpdListRequest(regNo: reglNumber);

    try {
      InvoiceListResponse result = await _networkHelper.opdList(req);

      LoadingUtils().hideLoading();

      if (result.items != null) {
        opdList.value = result.items!;
      } else {
        LoadingUtils().hideLoading();
        // buildAlertDialogWithChildren(
        //     Get.context!, true, 'information'.tr, result.message!);
      }
    } catch (e) {
      LoadingUtils().hideLoading();

      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'error'.tr,
        'server_error'.tr,
      );
    }
  }

  Future<void> getRegNo(
    String personalNumber, {
    required bool isIPD,
    Function? onSuccess,
  }) async {
    var req = CareOfRequest()
      ..personalNumber = personalNumber
      ..serviceCategory = "0";

    try {
      final result = await _appointmentService.getCareOf(req);

      if (result.success == true) {
        careOfPaientInfo.value = result.obj?.patientInfo ?? careOf.Info();
        if (isIPD) {
          getOpdList(careOfPaientInfo.value.id.toString());
        } else {
          getAdmissionList(careOfPaientInfo.value.id.toString());
        }
        if (onSuccess != null) {
          onSuccess();
        }
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'information'.tr,
          'went_wrong'.tr,
        );
      }
    } catch (e) {
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'information'.tr,
        'went_wrong'.tr,
      );
    }
  }

  Future<void> getAdmissionList(String reglNumber) async {
    admissionList.clear();
    opdList.clear();
    LoadingUtils().showLoading();

    var req = OpdListRequest(regNo: reglNumber);

    try {
      AdmissionListResponse result = await _networkHelper.admissionList(req);

      LoadingUtils().hideLoading();

      if (result.items != null) {
        admissionList.value = result.items!;
      } else {
        LoadingUtils().hideLoading();
      }
    } catch (e) {
      LoadingUtils().hideLoading();
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'error'.tr,
        'server_error'.tr,
      );
    }
  }

  Future<void> getAdmissionSummery(String admissionNumber) async {
    LoadingUtils().showLoading();
    var req = AdmissionSummeryRequest(admissionNo: admissionNumber);

    try {
      AppointmentSummeryResponse result = await _networkHelper.admissionSummery(
        req,
      );

      LoadingUtils().hideLoading();

      if (result.success == true) {
        admissionSummery.value = result;
        admissionBillSummery.value = result.model!.billSummary!;
        if (result.model!.headWiseTotalBillList != null) {
          admissionBillList.value = result.model!.headWiseTotalBillList!;
        } else {
          admissionBillList.value = [];
        }

        Get.to(AdmBillDetailsView());
      } else {
        LoadingUtils().hideLoading();
      }
    } catch (e) {
      LoadingUtils().hideLoading();
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'error'.tr,
        'server_error'.tr,
      );
    }
  }

  Future<void> payAdmissonBill({
    int? admissionNo,
    String? payAmt,
    String? orderId,
    String? remarks,
    Function? onSuccess,
  }) async {
    LoadingUtils().showLoading();
    var req = AdmissionBillRequest(
      admissionNo: admissionNo,
      payAmt: payAmt,
      orderId: orderId,
      remarks: remarks,
    );

    try {
      GlobalSubmitResponse result = await _networkHelper.admissionPay(req);

      LoadingUtils().hideLoading();

      if (result.success == true) {
        if (onSuccess != null) {
          onSuccess(); // Call the callback function on success
        }
      } else {
        LoadingUtils().hideLoading();
      }
    } catch (e) {
      LoadingUtils().hideLoading();
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'error'.tr,
        'server_error'.tr,
      );
    }
  }

  Future<void> payOpdBill({
    String? payAmt,
    String? orderId,
    String? invoiceId,
    Function? onSuccess,
  }) async {
    LoadingUtils().showLoading();
    var req = OpdPayRequest(
      payAmt: payAmt,
      orderId: orderId,
      invoiceId: invoiceId,
    );

    try {
      GlobalSubmitResponse result = await _networkHelper.opdPay(req);

      LoadingUtils().hideLoading();

      if (result.success == true) {
        if (onSuccess != null) {
          onSuccess();
        }
      } else {
        LoadingUtils().hideLoading();
      }
    } catch (e) {
      LoadingUtils().hideLoading();
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'error'.tr,
        'server_error'.tr,
      );
    }
  }

  Future<void> refreshSummery(
    String admissionNumber, {
    Function? onSuccess,
  }) async {
    LoadingUtils().showLoading();
    var req = AdmissionSummeryRequest(admissionNo: admissionNumber);

    try {
      AppointmentSummeryResponse result = await _networkHelper.admissionSummery(
        req,
      );

      LoadingUtils().hideLoading();

      if (result.success == true) {
        admissionSummery.value = result;
        admissionBillSummery.value = result.model!.billSummary!;
        if (result.model!.headWiseTotalBillList != null) {
          admissionBillList.value = result.model!.headWiseTotalBillList!;
        } else {
          admissionBillList.value = [];
        }
        if (onSuccess != null) {
          onSuccess(); // Call the onSuccess callback if provided
        }
      } else {
        LoadingUtils().hideLoading();
      }
    } catch (e) {
      LoadingUtils().hideLoading();
    }
  }
}
