import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';

/// A reusable loading indicator widget with colorAccent.
class LoadingUtils {
  showLoading() {
    Get.isDialogOpen ?? true
        ? const Offstage()
        : Get.dialog(
            const Center(child: SpinKitChasingDots(color: colorAccent)),
            barrierDismissible: false,
          );
  }

  hideLoading() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}
