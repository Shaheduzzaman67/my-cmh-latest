import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/custom_widgets/MateriaIconButton.dart';
import 'package:my_cmh_updated/custom_widgets/edit_text_witout_card.dart';
import 'package:my_cmh_updated/utils/string_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var authController = GetControllers.shared.getAuthController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var idPrefix = 'BA';
  int stateForExit = 0;
  var _saving = false;
  var username = '';
  var mobileNumber = '';
  var checkedValue = true;
  var accessToken = '';
  var email = '';
  var password = '';
  var dob = '';

  DateFormat dobFormat = DateFormat("MM/dd/yyyy");
  DateFormat dobFormatServer = DateFormat("yyyy-MM-dd");

  DateTime dobDate = DateTime.now();
  DateTime EDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "images/pattern_bg.png",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Color(0xF1FFFFFF).withOpacity(0.3),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Obx(
                    () => LoadingOverlayPro(
                      backgroundColor: Colors.black.withOpacity(0.7),
                      progressIndicator: CircularProgressIndicator(
                        color: colorAccent,
                      ),
                      isLoading: authController.isLoading.value,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Center(
                              child: Image(
                                image: AssetImage('images/app_icon.png'),
                                width: 150.0,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'user_registration'.tr,
                              style: TextStyle(
                                fontFamily: FONT_NAME,
                                fontSize: 30.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            EditTextWidgetWithoutCard(
                              hintText: 'personal_id_example'.tr,
                              labelText: 'personal_id'.tr,
                              iconData: Icons.dock,
                              inputType: TextInputType.text,
                              marginBottom: 5,
                              marginTop: 5,
                              onTextChange: (String text) {
                                print(text);
                                setState(() {});
                                username = text;
                              },
                              onDonePressed: (String value) {
                                print(value);
                              },
                            ),
                            EditTextWidgetWithoutCard(
                              hintText: 'mobile_number_example'.tr,
                              labelText: 'mobile_number'.tr,
                              iconData: Icons.send_to_mobile,
                              inputType: TextInputType.text,
                              marginBottom: 5,
                              marginTop: 5,
                              onTextChange: (String text) {
                                print(text);
                                setState(() {});
                                mobileNumber = text;
                              },
                              onDonePressed: (String value) {
                                print(value);
                              },
                            ),
                            EditTextWidgetWithoutCard(
                              hintText: 'email_example'.tr,
                              labelText: 'email'.tr,
                              iconData: Icons.send_to_mobile,
                              inputType: TextInputType.text,
                              marginBottom: 5,
                              marginTop: 5,
                              onTextChange: (String text) {
                                print(text);
                                setState(() {});
                                email = text;
                              },
                              onDonePressed: (String value) {
                                print(value);
                              },
                            ),
                            EditTextWidgetWithoutCard(
                              hintText: 'enter_password'.tr,
                              labelText: 'password_must'.tr,
                              invisiblePass: true,
                              isPass: true,
                              iconData: Icons.password_rounded,
                              inputType: TextInputType.text,
                              onTextChange: (String text) {
                                print(text);
                                setState(() {});
                                password = text;
                              },
                              marginBottom: 5,
                              marginTop: 5,
                              onDonePressed: (String value) {
                                print(value);
                              },
                            ),
                            Container(
                              // decoration: BoxDecoration(
                              //   border: Border.all(color: colorPrimary),
                              //   borderRadius: BorderRadius.all(Radius.circular(6.0)),
                              // ),
                              //margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 15.0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                ),
                                child: DateTimeField(
                                  decoration: InputDecoration(
                                    labelText: 'date_of_birth'.tr,
                                    labelStyle: TextStyle(),
                                    hintText: 'date_of_birth'.tr,
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: colorAccent,
                                    ),
                                    border: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: colorAccent,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: colorAccent,
                                      ),
                                    ),
                                  ),
                                  initialValue: EDate,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  onChanged: (DateTime? dateTime) {
                                    print(dobFormat.format(dateTime!));
                                    EDate = dateTime;
                                    setState(() {});
                                    dob = dobFormatServer.format(EDate);
                                    //dob = dobFormat.format(EDate);
                                  },
                                  format: dobFormat,
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime(1999),
                                      lastDate: DateTime.now(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            MaterialIconButton(
                              mColor: colorAccent,
                              margin: EdgeInsets.all(16),
                              height: 45.0,
                              width: 120.0,
                              circle: 8.0,
                              mChild: Container(
                                child: Text(
                                  'register'.tr,
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                              onClicked: () async {
                                FocusScope.of(context).unfocus();
                                if (username != '' &&
                                    dob != '' &&
                                    mobileNumber != '') {
                                  await authController.register(
                                    username: StringUtil.transformUsername(
                                      username,
                                    ),
                                    dob: dob,
                                    mobileNumber: mobileNumber,
                                    email: email,
                                    password: password,
                                  );
                                } else {
                                  buildAlertDialogWithChildren(
                                    context,
                                    true,
                                    'information'.tr,
                                    'required_data'.tr,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
