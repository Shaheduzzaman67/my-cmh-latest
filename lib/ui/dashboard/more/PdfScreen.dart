//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  static String id = '/PdfScreen';

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
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
                      'myCMH Documentation',
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
                      child: ImageIcon(
                        AssetImage("images/arrow.png"),
                        size: 24,
                        color: colorPrimary,
                      ),
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
                      : SfPdfViewer.asset('assets/myCMH Documentation.pdf'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
