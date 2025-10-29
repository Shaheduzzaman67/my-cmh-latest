import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/model-new/misc_info_response_model.dart';

import 'package:my_cmh_updated/utils/string_utils.dart';

// ignore: must_be_immutable
class RadiologyInfoDetailsView extends StatefulWidget {
  final String? title;

  final List<InfoItem>? info;

  const RadiologyInfoDetailsView({super.key, this.title, this.info});

  @override
  State<RadiologyInfoDetailsView> createState() =>
      _RadiologyInfoDetailsViewState();
}

class _RadiologyInfoDetailsViewState extends State<RadiologyInfoDetailsView> {
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
                    "ডিপার্টমেন্ট",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "অবস্থান",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
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
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            StringUtil.sanitize(nijuktiData.infoName ?? ''),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            StringUtil.sanitize(nijuktiData.infoPlaceBn ?? ''),
                          ),
                        ),
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
