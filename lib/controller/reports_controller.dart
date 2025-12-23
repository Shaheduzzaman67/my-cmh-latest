import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/model-new/care_of_request.dart';
import 'package:my_cmh_updated/model-new/care_of_response.dart' as careOf;
import 'package:my_cmh_updated/model-new/emr_investigation_list_response.dart'
    as labModel;
import 'package:my_cmh_updated/model-new/emr_radiology_list_response.dart';
import 'package:my_cmh_updated/model-new/investigation_report_request.dart';
import 'package:my_cmh_updated/model-new/investigation_report_request_list.dart';
import 'package:my_cmh_updated/services/reports_service.dart';
import 'package:my_cmh_updated/ui/reports/cmh_lab_report.dart';
import 'package:path_provider/path_provider.dart';

class ReportsController extends GetxController {
  final ReportsService _service = ReportsService();

  // Loading state
  final RxBool isLoading = false.obs;

  // Patient info
  final Rx<careOf.Info> careOfPatientInfo = careOf.Info().obs;

  // Lab reports
  final RxList<labModel.Item> labReportList = <labModel.Item>[].obs;

  // Radiology reports
  final RxList<RadiologyReportItem> radiologyReportList =
      <RadiologyReportItem>[].obs;

  final Rx<Uint8List?> pdfBytes = Rx<Uint8List?>(null);

  // Error handling
  final RxString errorMessage = ''.obs;

  /// Fetch patient care information
  Future<bool> fetchCareOfInfo({
    required String personalNumber,
    String serviceCategory = '0',
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final request = CareOfRequest()
        ..personalNumber = personalNumber
        ..serviceCategory = serviceCategory;

      final result = await _service.getCareOfInfo(request);

      if (result.obj?.patientInfo != null) {
        careOfPatientInfo.value = result.obj!.patientInfo!;
        isLoading.value = false;
        return true;
      } else {
        errorMessage.value = 'Failed to fetch patient information';
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      isLoading.value = false;
      return false;
    }
  }

  /// Fetch lab report list
  Future<void> fetchLabReportList(String hospitalId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final request = InvestigationReportListRequest()
        ..hospitalId = hospitalId
        ..fromDate = '01-Jan-2021'
        ..toDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());

      final result = await _service.getInvestigationReportList(request);

      if (result.success == true && result.items != null) {
        labReportList.value = result.items!;
        _sortLabReportsByDate();
      } else {
        labReportList.clear();
      }

      isLoading.value = false;
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      isLoading.value = false;
    }
  }

  /// Fetch radiology report list
  Future<void> fetchRadiologyReportList(String hospitalId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _service.getRadiologyReportList(hospitalId);

      if (result.success == true && result.items != null) {
        radiologyReportList.value = result.items!;
        _sortRadiologyReportsByDate();
      } else {
        radiologyReportList.clear();
      }

      isLoading.value = false;
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      isLoading.value = false;
    }
  }

  /// Fetch lab report PDF and return file path
  Future<String?> fetchLabReportPdf({
    required String invoiceId,
    required int stampNo,
    required String testPerform,
    required String itemName,
    required String itemID,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final request = InvestigationReportRequest()
        ..invoiceNo = invoiceId
        ..stampNo = stampNo
        ..testPerform = testPerform;

      final result = await _service.getLabReport(request);

      if (result.success == true && result.obj != null) {
        final filePath = await _createPdfFile(result.obj!, itemName);
        isLoading.value = false;
        return filePath;
      } else {
        if (testPerform == 'CMH LAB') {
          fetchCMHLabReport(itemId: itemID, stampNo: stampNo);
          return null;
        }

        errorMessage.value = result.message ?? 'No data available';
        isLoading.value = false;
        return null;
      }
    } catch (e) {
      errorMessage.value = 'Error: No data available';
      isLoading.value = false;
      return null;
    }
  }

  /// Create PDF file from base64 string
  Future<String?> _createPdfFile(String base64Data, String fileName) async {
    try {
      // Remove any whitespace or newlines from base64 string
      final cleanedBase64 = base64Data.replaceAll(RegExp(r'\s+'), '');

      // Decode base64 to bytes
      final bytes = base64Decode(cleanedBase64);

      // Get temporary directory
      final output = await getTemporaryDirectory();

      // Create file path with sanitized filename
      final sanitizedFileName = fileName.replaceAll(
        RegExp(r'[^a-zA-Z0-9_-]'),
        '_',
      );
      final file = File("${output.path}/$sanitizedFileName.pdf");

      // Write bytes directly (no buffer conversion needed)
      await file.writeAsBytes(bytes, flush: true);

      // Verify file was created successfully
      if (await file.exists() && await file.length() > 0) {
        return file.path;
      } else {
        errorMessage.value =
            'PDF file creation failed: File is empty or does not exist';
        return null;
      }
    } catch (e) {
      errorMessage.value = 'Failed to create PDF';
      return null;
    }
  }

  /// Sort lab reports by date (descending)
  void _sortLabReportsByDate() {
    labReportList.sort((a, b) {
      try {
        final dateA = DateTime.parse(a.invoiceDateTime!);
        final dateB = DateTime.parse(b.invoiceDateTime!);
        return dateB.compareTo(dateA);
      } catch (e) {
        return 0;
      }
    });
  }

  /// Sort radiology reports by date (descending)
  void _sortRadiologyReportsByDate() {
    radiologyReportList.sort((a, b) {
      try {
        final dateA = DateTime.parse(a.imgCaptureDate!);
        final dateB = DateTime.parse(b.imgCaptureDate!);
        return dateB.compareTo(dateA);
      } catch (e) {
        return 0;
      }
    });
  }

  Future<void> fetchCMHLabReport({
    required String itemId,
    required int stampNo,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      pdfBytes.value = null;

      final result = await _service.fetchCmhLabReport(
        itemId: itemId,
        stampNo: stampNo,
      );

      pdfBytes.value = result;
      Get.to(CmhLabReportViewer());
      isLoading.value = false;
    } catch (e) {
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'Error'.tr,
        'CMH Lab Report not found',
      );
      errorMessage.value = 'CMH Lab Report not found';
      isLoading.value = false;
    }
  }

  /// Clear all data
  void clearData() {
    labReportList.clear();
    radiologyReportList.clear();
    careOfPatientInfo.value = careOf.Info();
    errorMessage.value = '';
  }

  @override
  void onClose() {
    clearData();
    super.onClose();
  }
}
