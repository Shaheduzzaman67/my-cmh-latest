import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/ui/desk/list_loading_view.dart';
import 'package:my_cmh_updated/ui/desk/sub/info_details_view.dart';

// ignore: must_be_immutable
class DoctorsView extends StatefulWidget {
  @override
  State<DoctorsView> createState() => _DoctorsViewState();
}

class _DoctorsViewState extends State<DoctorsView> {
  var controller = GetControllers.shared.getHelpDeskController();

  @override
  void initState() {
    controller.getDoctorInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'বিশেষজ্ঞ চিকিৎসকগন',
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
                    _string('মেডিক্যাল বিভাগ', () {
                      Get.to(
                        InfoDetailsView(
                          title: 'মেডিক্যাল বিভাগ',
                          info: controller.medicalDoctorsInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('সার্জিক্যাল বিভাগ', () {
                      Get.to(
                        InfoDetailsView(
                          title: 'সার্জিক্যাল বিভাগ',
                          info: controller.sergicalDoctorsInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('স্ত্রীরোগ ও ধাত্রী বিদ্যা বিশেষজ্ঞ', () {
                      Get.to(
                        InfoDetailsView(
                          title: 'সার্জিক্যাল বিভাগ',
                          info: controller.sergicalDoctorsInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('রঞ্জনরশ্মি বিভাগ', () {
                      Get.to(
                        InfoDetailsView(
                          title: 'রঞ্জনরশ্মি বিভাগ',
                          info: controller.xrayDoctorsInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('	শিশু বিভাগ', () {
                      Get.to(
                        InfoDetailsView(
                          title: 'শিশু বিভাগ',
                          info: controller.childDoctorsInfo,
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    _string('ক্যান্সার সেন্টার', () {
                      Get.to(
                        InfoDetailsView(
                          title: 'ক্যান্সার সেন্টার',
                          info: controller.cancerDoctorsInfo,
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
