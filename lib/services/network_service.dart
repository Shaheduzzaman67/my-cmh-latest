import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/widgets/custom_no_internet_dialog.dart';

class NetworkService extends GetxService {
  final _connectivity = Connectivity();
  final RxBool isConnected = true.obs;
  bool _isDialogShowing = false;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _setupConnectivityStream();
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      // If there's an error checking connectivity, assume no connection
      _updateConnectionStatus([ConnectivityResult.none]);
    }
  }

  void _setupConnectivityStream() {
    _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        _updateConnectionStatus(result);
      },
      onError: (error) {
        debugPrint('Connectivity stream error: $error');
        // If there's an error in the stream, assume no connection
        _updateConnectionStatus([ConnectivityResult.none]);
      },
    );
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // If results list is empty or contains only 'none', assume no connection
    bool wasConnected = isConnected.value;
    isConnected.value = results.isNotEmpty &&
        !results.every((result) => result == ConnectivityResult.none);

    // Only show dialog if connection status actually changed
    if (!isConnected.value && wasConnected) {
      // Add slight delay to ensure UI is ready
      Future.delayed(Duration(milliseconds: 100), () {
        if (!isConnected.value && !_isDialogShowing) {
          _showNoInternetDialog();
        }
      });
    } else if (isConnected.value && !wasConnected && _isDialogShowing) {
      _dismissNoInternetDialog();
    }

    // Print status for debugging
    debugPrint(
        'Network status updated - Connected: ${isConnected.value}, Results: $results');
  }

  void _showNoInternetDialog() {
    if (!_isDialogShowing) {
      _isDialogShowing = true;
      Get.dialog(
        const CustomNoInternetDialog(),
        barrierDismissible: false,
      ).then((_) {
        // Reset dialog showing state if dialog is dismissed
        _isDialogShowing = false;
      });
    }
  }

  void _dismissNoInternetDialog() {
    if (_isDialogShowing) {
      Get.back();
      _isDialogShowing = false;
    }
  }
}
