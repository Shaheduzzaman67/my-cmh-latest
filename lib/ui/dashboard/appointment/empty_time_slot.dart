import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyTimeSlotWidget extends StatelessWidget {
  const EmptyTimeSlotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        child: Center(
          child: Text(
            "empty_time_slot".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black, // Text color
              fontSize: 16.0, // Font size
            ),
          ),
        ),
      ),
    );
  }
}
