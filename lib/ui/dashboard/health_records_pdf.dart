import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HealthRecordsPdf extends StatefulWidget {
  final String? pdfLocation;

  const HealthRecordsPdf({Key? key, this.pdfLocation}) : super(key: key);

  @override
  _HealthRecordsPdfState createState() => _HealthRecordsPdfState();
}

class _HealthRecordsPdfState extends State<HealthRecordsPdf> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 60),
            Material(
              shadowColor: Color(0xFFE9E9E9).withOpacity(0.7),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              elevation: 8,
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
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 16),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : SfPdfViewer.asset(widget.pdfLocation!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
