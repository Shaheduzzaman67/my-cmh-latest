import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/common/sessions.dart';
import 'package:my_cmh_updated/model-new/app_version_response_model.dart';
import 'package:my_cmh_updated/model-new/login_request.dart';
import 'package:my_cmh_updated/model-new/login_response.dart';
import 'package:my_cmh_updated/model-new/password_change_response.dart';
import 'package:my_cmh_updated/model-new/reg_request.dart';
import 'package:my_cmh_updated/model-new/reg_response.dart';
import 'package:my_cmh_updated/model-new/user_info_response.dart';
import 'package:my_cmh_updated/model-new/user_request.dart';
import 'package:my_cmh_updated/model/login/forgot_pass_req.dart';
import 'package:my_cmh_updated/services/auth_service.dart';
import 'package:my_cmh_updated/services/dislog_service.dart';
import 'package:my_cmh_updated/ui/auth/otp_verify.dart';
import 'package:my_cmh_updated/ui/dash_board_screen.dart';
import 'package:my_cmh_updated/utils/app_info_utils.dart';
import 'package:my_cmh_updated/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthController extends GetxController {
  final AuthNetworkService _networkHelper = AuthNetworkService();
  final RxBool isLoading = false.obs;
  final RxBool isDataLoaded = false.obs;
  var allUserList = <Item>[].obs;
  var patientName = <Item>[].obs;
  var appVersionInfo = Versions().obs;

  var selectedPatient;

  _launchURL() async {
    const urlAndroid =
        'https://play.google.com/store/apps/details?id=com.army.itdte.mycmh_patient';
    const urlIos = 'https://apps.apple.com/us/app/mycmh/id6470798599';
    if (await canLaunchUrl(
      Uri.parse(Platform.isAndroid ? urlAndroid : urlIos),
    )) {
      await launchUrl(Uri.parse(Platform.isAndroid ? urlAndroid : urlIos));
    } else {
      throw 'Could not launch ${(Platform.isAndroid ? urlAndroid : urlIos)}';
    }
  }

  Future<void> login(String username, String password) async {
    isLoading.value = true;

    var req = LoginRequest(
      userName: StringUtil.transformUsername(username),
      password: password.trim(),
    );

    try {
      LoginResponse result = await _networkHelper.loginUserNew(req);

      isLoading.value = false; // Hide loading state

      if (result.success == true) {
        Session.shared.saveUserId(
          StringUtil.transformUsername(username.toUpperCase()),
        );

        Get.to(DashBoardScreen());
      } else {
        if (result.message == null) {
          login(username, password); // Retry login
        } else {
          buildAlertDialogWithChildren(
            Get.context!,
            true,
            'information'.tr,
            result.message!,
          );
        }
      }
    } catch (e) {
      isLoading.value = false;
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'error'.tr,
        "Login failed. Please try again.",
      );
    }
  }

  Future<void> getUserInfo(String personalNumber) async {
    isLoading.value = true;

    var req = UserRequest(personalNumber: personalNumber.toUpperCase());

    try {
      UserInfoResponse result = await _networkHelper.getUserNew(req);

      isLoading.value = false;

      if (result.items != null && result.items!.isNotEmpty) {
        patientName.value = result.items!
            .where((element) => element.relationshipSerialNo == 0)
            .toList();
        allUserList.value = result.items ?? [];
        isDataLoaded.value = true;
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'information'.tr,
          result.message!,
        );
      }
    } catch (e) {
      isLoading.value = false;
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'error'.tr,
        'server_error'.tr,
      );
    }
  }

  Future<void> forgotPass(
    String username,
    String dob,
    String mobileNumber, {
    required VoidCallback callBack,
  }) async {
    isLoading.value = true;

    ForgotPassReq req = ForgotPassReq();
    req.personalId = StringUtil.transformUsername(username.toUpperCase());
    req.dob = dob;
    req.mobile = mobileNumber;

    try {
      PasswordChangeResponse result = await _networkHelper.forgotPasswordNew(
        req,
      );

      isLoading.value = false;

      if (result.otpStatus == 1) {
        callBack.call();
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'information'.tr,
          result.otpMessage!,
        );
      }
    } catch (e) {
      isLoading.value = false;
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'information'.tr,
        "Your data is not available under the username $username. Please provide a valid personal ID",
      );
    }
  }

  Future<void> register({
    required String username,
    required String password,
    required String dob,
    required String mobileNumber,
    String? email,
  }) async {
    isLoading.value = true;

    var req = RegRequest(
      userName: StringUtil.transformUsername(username),
      password: password,
      dob: dob,
      mobile: mobileNumber,
      email: email ?? '',
    );

    RegResponse result = await _networkHelper.registerUserNew(req);
    isLoading.value = false;

    if (result.success == true &&
        (result.obj?.patientInfo != null || result.instruction != null)) {
      Get.to(
        () => PinCodeVerificationScreen(
          StringUtil.transformUsername(username.toUpperCase()),
          result.instruction,
        ),
      );
    } else {
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'information'.tr,
        result.message ??
            'Your data is not available under the username $username. Please provide a valid personal ID',
      );
    }
  }

  Future<void> getAndroidVersion() async {
    try {
      AppVersionResponseModel result = await _networkHelper.getAndroidVersion();

      if (result.success != null && result.success == true) {
        appVersionInfo.value = result.versions!;
        final appVersion = AppInfoUtil.version;
        if (appVersion != result.versions?.version) {
          DialogService.appUpdaterDialog(
            title: 'update_title'.tr,
            content: result.versions?.changelog?.join('\n') ?? '',
            buttonText: 'update_now'.tr,
            onButtonPressed: () {
              _launchURL();
            },
            isDismissible: result.versions?.mandatoryUpdate == false,
          );
        }
      }
    } catch (e) {
      debugPrint('Error fetching app version: $e');
    }
  }
}
