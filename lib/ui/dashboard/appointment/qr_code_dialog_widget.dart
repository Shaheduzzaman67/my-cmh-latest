import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:get/get.dart';

class QrCodeDialogWidget extends StatelessWidget {
  final String personalNumber;
  final String apptID;

  QrCodeDialogWidget({
    required this.personalNumber,
    required this.apptID,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('qr_code'.tr),
      content: Container(
        width: 200.0,
        height: 150.0,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BarcodeWidget(
                data: personalNumber,
                barcode: Barcode.code128(),
                width: 200,
                height: 100,
                drawText: false,
              ),
              Text(apptID),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('cancel'.tr),
        ),
      ],
    );
  }
}
