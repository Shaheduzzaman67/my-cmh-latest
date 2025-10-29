import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/model-new/misc_info_response_model.dart';

import 'package:my_cmh_updated/utils/string_utils.dart';

// ignore: must_be_immutable
class DepartmentInfoDetailsView extends StatefulWidget {
  final String? title;

  final List<InfoItem>? info;

  const DepartmentInfoDetailsView({super.key, this.title, this.info});

  @override
  State<DepartmentInfoDetailsView> createState() =>
      _DepartmentInfoDetailsViewState();
}

class _DepartmentInfoDetailsViewState extends State<DepartmentInfoDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? '',
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "ওয়ার্ডের অবস্থান",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "ওয়ার্ডের অবস্থান",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "ওয়ার্ডের নাম",
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
              () => ListView.builder(
                itemCount: widget.info!.length,
                itemBuilder: (context, index) {
                  final nijuktiData = widget.info![index];
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
                            StringUtil.sanitize(nijuktiData.ingoPlaceEn ?? ''),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            StringUtil.sanitize(nijuktiData.infoPlaceBn ?? ''),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            StringUtil.sanitize(nijuktiData.infoName ?? ''),
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
          ),
        ],
      ),
    );
  }
}
