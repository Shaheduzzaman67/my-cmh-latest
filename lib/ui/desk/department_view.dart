import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/ui/desk/list_loading_view.dart';
import 'package:my_cmh_updated/ui/desk/sub/department_info_details_view.dart';
import 'package:my_cmh_updated/ui/desk/sub/pathology_info_details_view.dart';
import 'package:my_cmh_updated/ui/desk/sub/radiology_info_details_view.dart';

// ignore: must_be_immutable
class DepartmentView extends StatefulWidget {
  @override
  State<DepartmentView> createState() => _DepartmentViewState();
}

class _DepartmentViewState extends State<DepartmentView> {
  var controller = GetControllers.shared.getHelpDeskController();

  @override
  void initState() {
    controller.getDeptInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ওয়ার্ড/ডিপার্টমেন্ট',
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: FONT_NAME, // Ensure FONT_NAME is defined globally
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        backgroundColor: colorAccent, // Ensure `colorAccent` is defined
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.isSaving.value
              ? ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ShimmerListTile();
                  },
                )
              : Column(
                  children: [
                    SizedBox(height: 10),
                    _string('নতুন অফিসার্স ওয়ার্ড ১৪ তলা', () {
                      Get.to(
                        DepartmentInfoDetailsView(
                          title: 'নতুন অফিসার্স ওয়ার্ড ১৪ তলা',
                          info: controller.newOfficersDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('পুরাতন অফিসার্স ওয়ার্ড', () {
                      Get.to(
                        DepartmentInfoDetailsView(
                          title: 'পুরাতন অফিসার্স ওয়ার্ড',
                          info: controller.oldOfficersDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('মেডিসিন বিল্ডিং', () {
                      Get.to(
                        DepartmentInfoDetailsView(
                          title: 'মেডিসিন বিল্ডিং',
                          info: controller
                              .medicineBuildingsOfficersDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('সার্জারী বিল্ডিং', () {
                      Get.to(
                        DepartmentInfoDetailsView(
                          title: 'সার্জারী বিল্ডিং',
                          info: controller.surgeryBuildingsDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('অর্থোপেডিক বিল্ডিং', () {
                      Get.to(
                        RadiologyInfoDetailsView(
                          title: 'অর্থোপেডিক বিল্ডিং',
                          info: controller.orthopedicDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('কার্ডিওলজি বিল্ডিং', () {
                      Get.to(
                        DepartmentInfoDetailsView(
                          title: 'কার্ডিওলজি বিল্ডিং',
                          info: controller.cardiologyDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('আই, ইএনটি বিল্ডিং', () {
                      Get.to(
                        DepartmentInfoDetailsView(
                          title: 'আই, ইএনটি বিল্ডিং',
                          info: controller.entBuildingsDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('রেডিওলজি বিল্ডিং', () {
                      Get.to(
                        RadiologyInfoDetailsView(
                          title: 'রেডিওলজি বিল্ডিং',
                          info: controller.radiologyBuildingsDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string("ওআর'স ফ্যামিলি ওয়ার্ড", () {
                      Get.to(
                        DepartmentInfoDetailsView(
                          title: "ওআর'স ফ্যামিলি ওয়ার্ড",
                          info: controller.orsFamilyDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string("ওআর'স ফ্যামিলি গাইনী ওয়ার্ড", () {
                      Get.to(
                        DepartmentInfoDetailsView(
                          title: "ওআর'স ফ্যামিলি গাইনী ওয়ার্ড",
                          info: controller.orsFamilyGyneDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('ওটি, আইসিইউ, এইচডিইউ', () {
                      Get.to(
                        PathologyInfoDetailsView(
                          title: 'ওটি, আইসিইউ, এইচডিইউ',
                          info: controller.otIcuDepartmentInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string("প্যাথলজি", () {
                      Get.to(
                        PathologyInfoDetailsView(
                          title: 'প্যাথলজি',
                          info: controller.pathologyDepartmentInfo,
                        ),
                      );
                    }),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _string(String title, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: colorGreen,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: FONT_NAME2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
