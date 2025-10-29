import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/ui/desk/list_loading_view.dart';
import 'package:my_cmh_updated/utils/string_utils.dart';

// ignore: must_be_immutable
class AdminView extends StatefulWidget {
  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  var controller = GetControllers.shared.getHelpDeskController();

  @override
  void initState() {
    controller.getAdminInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'এ্যাডমিন',
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: FONT_NAME,
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
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "পদবী",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "নাম",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "নিয়োগ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "যোগাযোগ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.isSaving.value
                  ? ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ShimmerListTile();
                      },
                    )
                  : ListView.builder(
                      itemCount: controller.adminInfo.length,
                      itemBuilder: (context, index) {
                        final nijuktiData = controller.adminInfo[index];
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
                                  StringUtil.sanitize(
                                    nijuktiData.infoRank ?? '',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  StringUtil.sanitize(
                                    nijuktiData.infoName ?? '',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  StringUtil.sanitize(
                                    nijuktiData.infoAppointment ?? '',
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: nijuktiData.infoMobile != null
                                    ? GestureDetector(
                                        onTap: () {
                                          makePhoneCall(
                                            'tel: ${StringUtil.mobileNumberSanitize(nijuktiData.infoMobile!)}',
                                          );
                                        },
                                        child: Text(
                                          StringUtil.mobileNumberSanitize(
                                            nijuktiData.infoMobile!,
                                          ),
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
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
          ),
        ],
      ),
    );
  }
}
