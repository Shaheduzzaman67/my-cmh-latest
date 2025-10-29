import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/ui/dashboard/health_records_pdf.dart';
// ignore: unused_import
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HealthRecordsScreen extends StatefulWidget {
  static String id = '/HealthRecords';

  @override
  _HealthRecordsScreenState createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> {
  List title = [
    'balanced_diet'.tr,
    'balanced_diet_children'.tr,
    'carcinoma_diet'.tr,
    'diabetic_diet'.tr,
    'diabetic_renal_diet'.tr,
    'diarrheal_diet'.tr,
    'diet_chart_baby_1y'.tr,
    'diet_chart_baby_2y'.tr,
    'gallbladder_diet'.tr,
    'high_fiber_diet'.tr,
    'iron_rich_diet'.tr,
    'kids_diet_2y_3y'.tr,
    'kids_diet_6m_8m'.tr,
    'kids_diet_9m_12m'.tr,
  ];

  List asset = [
    'assets/Balanced Diet.pdf',
    'assets/Balanced Diet for children.pdf',
    'assets/Carcinoma Diet.pdf',
    'assets/Diabetic Diet.pdf',
    'assets/Diabetic Renal Diet.pdf',
    'assets/Diarrheal Diet.pdf',
    'assets/Diet chart (baby) -1y.pdf',
    'assets/Diet chart (baby)- 2y.pdf',
    'assets/Gallbladder Diet.pdf',
    'assets/High Fiber Diet.pdf',
    'assets/Iron Rich Diet.pdf',
    'assets/Kids Diet 2y-3y.pdf',
    'assets/Kids Diet 6 m -8 m.pdf',
    'assets/Kids Diet 9 m -12 m.pdf',
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 60),
            Material(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              elevation: 0,
              child: Container(
                child: ListTile(
                  title: Text(
                    "food_nutrition".tr,
                    style: TextStyle(
                      fontFamily: FONT_NAME,
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: title.length,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 4.0,
                      bottom: 4.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HealthRecordsPdf(pdfLocation: asset[index]),
                          ),
                        );
                      },
                      leading: Icon(Icons.picture_as_pdf_rounded, size: 35),
                      title: Container(
                        margin: EdgeInsets.only(
                          left: 0.0,
                          right: 0.0,
                          top: 12.0,
                          bottom: 4.0,
                        ),
                        child: Text(
                          title[index],
                          style: TextStyle(
                            fontFamily: FONT_NAME2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorPrimary,
                          ),
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 35),
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
