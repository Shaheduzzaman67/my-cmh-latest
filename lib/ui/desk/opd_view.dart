import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/ui/desk/list_loading_view.dart';
import 'package:my_cmh_updated/utils/string_utils.dart';

// ignore: must_be_immutable
class OpdView extends StatefulWidget {
  @override
  State<OpdView> createState() => _OpdViewState();
}

class _OpdViewState extends State<OpdView> {
  var controller = GetControllers.shared.getHelpDeskController();

  @override
  void initState() {
    controller.getOpdInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ওপিডি সমুহ',
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
        child: Column(
          children: [
            Container(
              color: colorGreen,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ইমার্জেন্সি বিল্ডিংয়ের ভিতরে ওপিডি সমুহের অবস্থান",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: FONT_NAME2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "ওপিডির নাম",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      "ওপিডির অবস্থান",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "দিন সমূহ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "নাম্বার",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.isSaving.value
                  ? ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ShimmerListTile();
                      },
                    )
                  : ListView.builder(
                      itemCount: controller.tempOneOpdInfo.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final opdData = controller.tempOneOpdInfo[index];
                        return SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                              top: 8,
                              bottom: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    StringUtil.sanitize(opdData.infoName ?? ''),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    StringUtil.sanitize(
                                      opdData.infoPlaceBn ?? '',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    StringUtil.sanitize(
                                      opdData.serviceDays ?? '',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Expanded(
                                  child: opdData.infoMobile != null
                                      ? GestureDetector(
                                          onTap: () {
                                            makePhoneCall(
                                              'tel: ${StringUtil.mobileNumberSanitize(opdData.infoMobile!)}',
                                            );
                                          },
                                          child: Text(
                                            StringUtil.mobileNumberSanitize(
                                              opdData.infoMobile!,
                                            ),
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 13,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Obx(
              () => controller.isSaving.value == false
                  ? Container(
                      color: colorGreen,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ইমার্জেন্সি বিল্ডিংয়ের বহিরে অন্যান্ন ওপিডি সমুহের অবস্থান",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: FONT_NAME2,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ),
            Obx(
              () => controller.isSaving.value == false
                  ? Container(
                      color: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "ওপিডির নাম",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              "ওপিডির অবস্থান",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "দিন সমূহ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "নাম্বার",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ),
            Obx(
              () => ListView.builder(
                itemCount: controller.tempTwoOpdInfo.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final opdData = controller.tempTwoOpdInfo[index];
                  return Container(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 8,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            StringUtil.sanitize(opdData.infoName ?? ''),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            StringUtil.sanitize(opdData.infoPlaceBn ?? ''),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            StringUtil.sanitize(opdData.serviceDays ?? ''),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          child: opdData.infoMobile != null
                              ? GestureDetector(
                                  onTap: () {
                                    makePhoneCall(
                                      'tel: ${StringUtil.mobileNumberSanitize(opdData.infoMobile!)}',
                                    );
                                  },
                                  child: Text(
                                    StringUtil.mobileNumberSanitize(
                                      opdData.infoMobile!,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
