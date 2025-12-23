import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:my_cmh_updated/services/radiology_report_service.dart';

class RadiologyReportController extends GetxController {
  final RadiologyReportService _service = RadiologyReportService();

  final RxBool isLoading = false.obs;
  final Rx<Uint8List?> pdfBytes = Rx<Uint8List?>(null);
  final RxString errorMessage = ''.obs;

  Future<void> fetchRadiologyReport({
    required String invoiceNo,
    required String itemNo,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      pdfBytes.value = null;

      final result = await _service.fetchRadiologyReport(
        invoiceNo: invoiceNo,
        itemNo: itemNo,
      );

      pdfBytes.value = result;
      isLoading.value = false;
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
  }

  void clearError() {
    errorMessage.value = '';
  }

  @override
  void onClose() {
    super.onClose();
  }
}
