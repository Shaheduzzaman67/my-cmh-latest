import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/utils/surjopay_util.dart';

class DialogService {
  /// Shows a reusable dialog with a title, content and a button.
  ///
  /// [title] and [content] are the translated strings.
  /// [buttonText] provides custom text for the button; defaults to "OK".
  /// [onButtonPressed] can be provided to perform an action on button tap.
  static Future<void> appUpdaterDialog({
    required String title,
    required String content,
    bool? isDismissible,
    String buttonText = "OK",
    VoidCallback? onButtonPressed,
  }) async {
    await Get.dialog(
      PopScope(
        canPop: false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('images/update.svg', height: 30),
                // Title
                Text(
                  title.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Body content
                Text(content.tr, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                if (isDismissible == true)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // Optional: rounded corners
                        ),
                      ),
                      child: Text('cancel'.tr),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (onButtonPressed != null) {
                        onButtonPressed();
                      }
                      SystemChannels.platform.invokeMethod(
                        'SystemNavigator.pop',
                      );
                      // Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // Optional: rounded corners
                      ),
                    ),
                    child: Text(buttonText.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: isDismissible ?? true,
    );
  }

  static Future<void> showWarningDialog({
    required String title,
    required String content,
    bool? isDismissible,
    String buttonText = "OK",
  }) async {
    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_rounded, size: 50),
              // Title
              Text(
                title.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // Body content
              Text(
                content.tr,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              if (isDismissible == true)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // Optional: rounded corners
                      ),
                    ),
                    child: Text('cancel'.tr),
                  ),
                ),
            ],
          ),
        ),
      ),
      barrierDismissible: isDismissible ?? true,
    );
  }

  static void showSuccessDialog(BuildContext context, PaymentResult result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('Payment Successful'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your payment has been processed successfully.'),
            const SizedBox(height: 8),
            if (result.orderID != null) ...[
              Text(
                'Order ID: ${result.orderID}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
            ],
            if (result.spCode != null) ...[
              Text(
                'Transaction Code: ${result.spCode}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showErrorDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.error, color: Colors.red, size: 28),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
