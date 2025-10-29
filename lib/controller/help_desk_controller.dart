import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/model-new/misc_info_response_model.dart';
import 'package:my_cmh_updated/services/networking.dart';
import 'package:my_cmh_updated/utils/string_utils.dart';

class HelpDeskController extends GetxController {
  NetworkHelper networkHelper = NetworkHelper();

  RxBool isSaving = false.obs;

  var nijuktiInfo = <InfoItem>[].obs;

  var tempOneOpdInfo = <InfoItem>[].obs;
  var tempTwoOpdInfo = <InfoItem>[].obs;
  var adminInfo = <InfoItem>[].obs;

  var medicalDoctorsInfo = <InfoItem>[].obs;
  var sergicalDoctorsInfo = <InfoItem>[].obs;
  var gyneDoctorsInfo = <InfoItem>[].obs;
  var xrayDoctorsInfo = <InfoItem>[].obs;
  var cancerDoctorsInfo = <InfoItem>[].obs;
  var childDoctorsInfo = <InfoItem>[].obs;

  var newOfficersDepartmentInfo = <InfoItem>[].obs;
  var oldOfficersDepartmentInfo = <InfoItem>[].obs;
  var medicineBuildingsOfficersDepartmentInfo = <InfoItem>[].obs;
  var surgeryBuildingsDepartmentInfo = <InfoItem>[].obs;
  var orthopedicDepartmentInfo = <InfoItem>[].obs;
  var cardiologyDepartmentInfo = <InfoItem>[].obs;
  var entBuildingsDepartmentInfo = <InfoItem>[].obs;
  var radiologyBuildingsDepartmentInfo = <InfoItem>[].obs;
  var orsFamilyDepartmentInfo = <InfoItem>[].obs;
  var orsFamilyGyneDepartmentInfo = <InfoItem>[].obs;
  var otIcuDepartmentInfo = <InfoItem>[].obs;
  var pathologyDepartmentInfo = <InfoItem>[].obs;

  Future<void> getNijuktiInfo() async {
    isSaving.value = true;

    await networkHelper.getInfoNijukti().then((result) async {
      isSaving.value = false;
      if (result.success == true) {
        if (result.items != null) {
          nijuktiInfo.value = result.items!;
        }
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'error'.tr,
          'server_error'.tr,
        );
      }
    });
    isSaving.value = false;
  }

  Future<void> getOpdInfo() async {
    isSaving.value = true;

    await networkHelper.getInfoOpd().then((result) async {
      isSaving.value = false;
      if (result.success == true) {
        if (result.items != null) {
          tempOneOpdInfo.value = result.items!
              .where(
                (item) =>
                    StringUtil.mobileNumberSanitize(item.infoBuilding) ==
                    'ইমার্জেন্সি বিল্ডিংয়ের ভিতরে ওপিডি সমুহের অবস্থান',
              )
              .toList();

          tempTwoOpdInfo.value = result.items!
              .where(
                (item) =>
                    StringUtil.mobileNumberSanitize(item.infoBuilding) ==
                    'ইমার্জেন্সি বিল্ডিংয়ের বহিরে অন্যান্ন ওপিডি সমুহের অবস্থান',
              )
              .toList();
        }
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'error'.tr,
          'server_error'.tr,
        );
      }
    });
    isSaving.value = false;
  }

  Future<void> getAdminInfo() async {
    isSaving.value = true;

    await networkHelper.getInfoAdmin().then((result) async {
      isSaving.value = false;
      if (result.success == true) {
        if (result.items != null) {
          adminInfo.value = result.items!;
        }
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'error'.tr,
          'server_error'.tr,
        );
      }
    });
    isSaving.value = false;
  }

  Future<void> getDeptInfo() async {
    isSaving.value = true;

    await networkHelper.getInfoDept().then((result) async {
      isSaving.value = false;
      if (result.success == true) {
        if (result.items != null) {
          newOfficersDepartmentInfo.value = result.items!
              .where(
                (item) => StringUtil.sanitize(
                  item.infoBuilding,
                ).contains('নতুন অফিসার্স ওয়ার্ড ১৪ তলা'),
              )
              .toList();

          oldOfficersDepartmentInfo.value = result.items!
              .where(
                (item) => StringUtil.sanitize(
                  item.infoBuilding,
                ).contains('পুরাতন অফিসার্স ওয়ার্ড'),
              )
              .toList();

          medicineBuildingsOfficersDepartmentInfo.value = result.items!.where((
            item,
          ) {
            final sanitized = StringUtil.sanitize(item.infoBuilding);
            return sanitized.contains('মেডিসিন বিল্ডিং') ||
                sanitized.contains('মেডিক্যাল বিল্ডিং'); // Extra condition
          }).toList();

          surgeryBuildingsDepartmentInfo.value = result.items!
              .where(
                (item) => StringUtil.sanitize(
                  item.infoBuilding,
                ).contains('সার্জারী বিল্ডিং'),
              )
              .toList();

          orthopedicDepartmentInfo.value = result.items!
              .where(
                (item) => StringUtil.sanitize(
                  item.infoBuilding,
                ).contains('অর্থোপেডিক বিল্ডিং'),
              )
              .toList();

          cardiologyDepartmentInfo.value = result.items!
              .where(
                (item) => StringUtil.sanitize(
                  item.infoBuilding,
                ).contains('কার্ডিওলজি বিল্ডিং'),
              )
              .toList();

          entBuildingsDepartmentInfo.value = result.items!
              .where(
                (item) => StringUtil.sanitize(
                  item.infoBuilding,
                ).contains('আই, ইএনটি বিল্ডিং'),
              )
              .toList();

          radiologyBuildingsDepartmentInfo.value = result.items!
              .where(
                (item) => StringUtil.sanitize(
                  item.infoBuilding,
                ).contains('রেডিওলজি বিল্ডিং'),
              )
              .toList();

          orsFamilyDepartmentInfo.value = result.items!
              .where(
                (item) => StringUtil.sanitize(
                  item.infoBuilding,
                ).contains("ওআর'স ফ্যামিলি ওয়ার্ড"),
              )
              .toList();

          orsFamilyGyneDepartmentInfo.value = result.items!
              .where(
                (item) => StringUtil.sanitize(
                  item.infoBuilding,
                ).contains("ওআর'স ফ্যামিলি গাইনী ওয়ার্ড"),
              )
              .toList();

          otIcuDepartmentInfo.value = result.items!
              .where(
                (item) => StringUtil.sanitize(
                  item.infoBuilding,
                ).contains('ওটি, আইসিইউ, এইচডিইউ'),
              )
              .toList();

          pathologyDepartmentInfo.value = result.items!
              .where(
                (item) =>
                    StringUtil.sanitize(item.infoBuilding).contains('প্যাথলজি'),
              )
              .toList();
        }
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'error'.tr,
          'server_error'.tr,
        );
      }
    });
    isSaving.value = false;
  }

  Future<void> getDoctorInfo() async {
    isSaving.value = true;

    await networkHelper.getInfoDoctors().then((result) async {
      isSaving.value = false;
      if (result.success == true) {
        if (result.items != null) {
          medicalDoctorsInfo.value = result.items!
              .where(
                (item) => StringUtil.mobileNumberSanitize(
                  item.infoBuilding,
                ).contains('Medical'),
              )
              .toList();

          sergicalDoctorsInfo.value = result.items!
              .where(
                (item) => StringUtil.mobileNumberSanitize(
                  item.infoBuilding,
                ).contains('Surgical'),
              )
              .toList();

          gyneDoctorsInfo.value = result.items!
              .where(
                (item) => StringUtil.mobileNumberSanitize(
                  item.infoBuilding,
                ).contains('Gyne'),
              )
              .toList();

          xrayDoctorsInfo.value = result.items!
              .where(
                (item) => StringUtil.mobileNumberSanitize(
                  item.infoBuilding,
                ).contains('XRAY'),
              )
              .toList();

          cancerDoctorsInfo.value = result.items!
              .where(
                (item) => StringUtil.mobileNumberSanitize(
                  item.infoBuilding,
                ).contains('Cancer'),
              )
              .toList();

          childDoctorsInfo.value = result.items!
              .where(
                (item) => StringUtil.mobileNumberSanitize(
                  item.infoBuilding,
                ).contains('Child'),
              )
              .toList();
        }
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'error'.tr,
          'server_error'.tr,
        );
      }
    });
    isSaving.value = false;
  }
}
