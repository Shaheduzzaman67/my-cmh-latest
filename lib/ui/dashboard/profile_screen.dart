import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/common/sessions.dart';
import 'package:my_cmh_updated/common/shared_pref_key.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/localize/app_labels.dart';
import 'package:my_cmh_updated/localize/localization_service.dart';
import 'package:my_cmh_updated/model-new/remove_account_request.dart';
import 'package:my_cmh_updated/services/networking.dart';
import 'package:my_cmh_updated/ui/auth/login_screen.dart';
import 'package:my_cmh_updated/ui/auth/otp_verify_pass_change.dart';
import 'package:my_cmh_updated/utils/base64_image_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'more/PdfScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authController = GetControllers.shared.getAuthController();
  final appointmentController = GetControllers.shared
      .getAppointmentController();
  bool _loading = false;
  bool _saving = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? _selectedLang;

  @override
  void initState() {
    _loadLanguagePreference();
    super.initState();
    getUserData();
  }

  Future<void> _loadLanguagePreference() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _selectedLang =
          prefs.getString(SharedPreferenceKeys.language) ?? 'English';
    });
  }

  Future<void> getUserData() async {
    final personalID = await Session.shared.getUserId();
    await appointmentController.getCareOf(personalID);
  }

  Future<void> removeAccount() async {
    setState(() => _saving = true);

    try {
      final networkHelper = NetworkHelper();
      final req = RemoveAccountRequest()
        ..personalNumber = appointmentController
            .careOfPaientInfo
            .value
            .personalNumber
            .toString();

      final result = await networkHelper.removeAccount(req);

      if (result?.success == true) {
        Navigator.popAndPushNamed(context, LoginScreen.id);
      } else {
        buildAlertDialogWithChildren(
          context,
          true,
          'information'.tr,
          result?.message ?? 'Unknown error occurred',
        );
      }
    } finally {
      setState(() => _saving = false);
    }
  }

  Future<void> logOut() async {
    await Session.shared.clearSlotDate();
    await Session.shared.clearUserId();
    Navigator.popAndPushNamed(context, LoginScreen.id);
  }

  Widget _buildProfileHeader() {
    return SliverAppBar(
      pinned: true,
      elevation: 8,
      backgroundColor: Colors.white,
      shadowColor: const Color(0xFFE9E9E9).withOpacity(0.7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
        ),
      ),
      title: Text(
        'user_profile'.tr,
        style: const TextStyle(
          fontSize: 18.0,
          fontFamily: FONT_NAME,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      leading: ImageIcon(
        const AssetImage("images/select_patient.png"),
        size: 30,
        color: colorPrimary,
      ),
    );
  }

  Widget _buildProfileImage() {
    return Obx(
      () => appointmentController.isLoading.value
          ? _defaultShimmer(100, 100)
          : appointmentController.careOfPaientInfo.value.photo != null
          ? Base64ImageUtil.fromBase64String(
              appointmentController.careOfPaientInfo.value.photo ?? '',
              width: 100,
              height: 100,
            )
          : const SizedBox(),
    );
  }

  Widget _changeLanguage() {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colorAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton(
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: colorAccent,
        isExpanded: true,
        underline: const SizedBox(),
        value: _selectedLang,
        items: LocalizationService.langs.map((String lang) {
          return DropdownMenuItem(
            value: lang,
            child: Text(
              lang,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() => _selectedLang = value);
          LocalizationService().changeLocale(value!);
        },
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Material(
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(6),
        elevation: 0,
        color: colorGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Obx(
                () => _buildInfoRow(
                  'name'.tr,
                  appointmentController.careOfPaientInfo.value.patientName ??
                      'N/A',
                ),
              ),
              Obx(
                () => _buildInfoRow(
                  'user_id'.tr,
                  appointmentController.careOfPaientInfo.value.personalNumber ??
                      'N/A',
                ),
              ),
              Obx(
                () => _buildInfoRow(
                  'phone_number'.tr,
                  appointmentController.careOfPaientInfo.value.phoneMobile ??
                      'N/A',
                ),
              ),
              Obx(
                () => _buildInfoRow(
                  'rank'.tr,
                  appointmentController.careOfPaientInfo.value.rankName ??
                      'N/A',
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'change_language'.tr,
                      style: TextStyle(color: Colors.black),
                    ),
                    _changeLanguage(),
                  ],
                ),
              ),
              _buildActionButton(
                'password_change'.tr,
                Icons.password,
                Colors.white,
                backgroundColor: colorPrimary,
                onTap: () => authController.forgotPass(
                  appointmentController.careOfPaientInfo.value.personalNumber
                      .toString(),
                  appointmentController.careOfPaientInfo.value.dob ?? '',
                  callBack: () => Get.to(
                    () => ChangePassPinCodeVerificationScreen(
                      appointmentController
                          .careOfPaientInfo
                          .value
                          .personalNumber
                          .toString(),
                    ),
                  ),
                ),
              ),
              _buildActionButton(
                'how_to_use'.tr,
                Icons.info,
                Colors.white,
                onTap: () => Navigator.pushNamed(context, PdfScreen.id),
                backgroundColor: colorPrimary,
                elevation: 4,
              ),
              if (Platform.isIOS) ...[
                _buildActionButton(
                  'remove_my_account'.tr,
                  Icons.delete_forever,
                  backgroundColor: colorPrimary,
                  Colors.white,
                  onTap: () => _showRemoveAccountDialog(),
                ),
              ],
              _buildActionButton(
                'logout'.tr,
                Icons.logout,
                Colors.white,
                backgroundColor: colorPrimary,
                onTap: () => _showLogoutDialog(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: FONT_NAME2,
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontFamily: FONT_NAME2,
              fontSize: 14.0,
              color: Colors.grey[700],
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String title,
    IconData? icon,
    Color textColor, {
    VoidCallback? onTap,
    String? iconAsset,
    Color? backgroundColor,
    double elevation = 0,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Material(
        shadowColor: Colors.grey[900],
        borderRadius: BorderRadius.circular(6),
        elevation: elevation,
        color: backgroundColor ?? colorGrey,
        child: Container(
          height: 50,
          child: Center(
            child: ListTile(
              title: Text(
                title,
                style: GoogleFonts.nunitoSans(
                  fontSize: 17.0,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: iconAsset != null
                  ? Image(image: AssetImage(iconAsset), height: 30, width: 30)
                  : Icon(icon, size: 30, color: Colors.white),
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }

  void _showRemoveAccountDialog() {
    Dialogs.materialDialog(
      msg: 'remove_my_account_details'.tr,
      title: "warning".tr,
      msgStyle: GoogleFonts.lato(color: Colors.black, fontSize: 14),
      titleStyle: GoogleFonts.lato(
        color: colorPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      barrierDismissible: true,
      color: Colors.white,
      context: context,
      actions: [
        _buildDialogButton('ok'.tr, () {
          Navigator.pop(context);
          removeAccount();
        }),
        _buildDialogButton('cancel'.tr, () => Navigator.pop(context)),
      ],
    );
  }

  void _showLogoutDialog() {
    Dialogs.materialDialog(
      msg: 'logout_confirm'.tr,
      title: "logout".tr,
      msgStyle: GoogleFonts.lato(color: Colors.black, fontSize: 14),
      titleStyle: GoogleFonts.lato(
        color: colorPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      barrierDismissible: true,
      color: Colors.white,
      context: context,
      actions: [
        _buildDialogButton('logout'.tr, () {
          Navigator.pop(context);
          logOut();
        }),
        _buildDialogButton('cancel'.tr, () => Navigator.pop(context)),
      ],
    );
  }

  Widget _buildDialogButton(String text, VoidCallback onPressed) {
    return TextButton(
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          fontSize: 14.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: onPressed,
    );
  }

  static Widget _defaultShimmer(double? width, double? height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width ?? 100,
        height: height ?? 100,
        color: Colors.grey.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayPro(
      isLoading: _loading,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildProfileHeader(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildProfileImage(),
                  _buildProfileInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
