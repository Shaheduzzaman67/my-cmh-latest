import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/ui/desk/admin_view.dart';
import 'package:my_cmh_updated/ui/desk/department_view.dart';
import 'package:my_cmh_updated/ui/desk/doctors_view.dart';

import 'package:my_cmh_updated/ui/desk/nijukti_view.dart';
import 'package:my_cmh_updated/ui/desk/opd_view.dart';
import 'package:my_cmh_updated/ui/widget/item_card_view.dart';

class DeskInfoScreen extends StatelessWidget {
  static String id = '/DeskInfo';

  final List<Map<String, String>> items = [
    {"name": "গুরুত্বপূর্ণ নিযুক্তি"},
    {"name": "ওপিডি সমুহ"},
    {"name": "ওয়ার্ড/ডিপার্টমেন্ট"},
    {"name": "বিশেষজ্ঞ চিকিৎসকগন"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'help_desk_app_bar'.tr,
          style: TextStyle(
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
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        backgroundColor: colorAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5, // Adjust for layout balance
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  Get.to(NijuktiView());
                }
                if (index == 1) {
                  Get.to(OpdView());
                }

                if (index == 2) {
                  Get.to(DepartmentView());
                }
                if (index == 3) {
                  Get.to(DoctorsView());
                }
              },
              child: ItemWidget(name: items[index]["name"]!, fontSize: 15),
            );
          },
        ),
      ),
    );
  }
}
