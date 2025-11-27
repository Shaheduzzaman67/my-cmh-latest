import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/custom_widgets/MateriaIconButton.dart';
import 'package:my_cmh_updated/ui/auth/forgot_screen.dart';
import 'package:my_cmh_updated/ui/auth/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  var authController = GetControllers.shared.getAuthController();

  int stateForExit = 0;

  var username = '';
  var password = '';

  bool indicator = true;

  @override
  void initState() {
    getAppUpdate();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getAppUpdate() async {
    await authController.getAndroidVersion();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
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
                            SizedBox(height: 20.0),
                            Center(
                              child: Image(
                                image: AssetImage('images/app_icon.png'),
                                width: 150.0,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            SizedBox(height: 20.0),
                            Text(
                              'login'.tr,
                              style: TextStyle(
                                fontFamily: FONT_NAME,
                                fontSize: 30.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 50.0),
                            AutofillGroup(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 6.0,
                                      right: 6,
                                    ),
                                    child: TextField(
                                      onChanged: (value) {
                                        username = value;
                                      },
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      autofillHints: [AutofillHints.username],
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.top,
                                      decoration: InputDecoration(
                                        labelText: 'personal_id'.tr,
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          //letterSpacing: 1.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        hintStyle: GoogleFonts.quicksand(
                                          fontSize: 13,
                                          letterSpacing: 1.4,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'personal_id_example'.tr,
                                        icon: Icon(
                                          CupertinoIcons.profile_circled,
                                          color: colorAccent,
                                        ),
                                        border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 6.0,
                                      right: 6,
                                    ),
                                    child: TextField(
                                      onChanged: (value) {
                                        password = value;
                                      },
                                      onEditingComplete: () =>
                                          TextInput.finishAutofillContext(),
                                      keyboardType: TextInputType.text,
                                      obscureText: indicator,
                                      autofillHints: [AutofillHints.password],
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.top,
                                      decoration: InputDecoration(
                                        labelText: 'password'.tr,
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          //letterSpacing: 1.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        hintStyle: GoogleFonts.quicksand(
                                          fontSize: 13,
                                          letterSpacing: 1.4,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'password'.tr,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            indicator
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              indicator = !indicator;
                                            });
                                          },
                                        ),
                                        icon: Icon(
                                          CupertinoIcons.lock,
                                          color: colorAccent,
                                        ),
                                        border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Text(
                                      'Support'.tr,
                                      style: TextStyle(
                                        color: colorPrimary,
                                        fontFamily: FONT_NAME2,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    onTap: () {
                                      FocusScope.of(context).unfocus();

                                      showSupportDialog(context);
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'forget_password'.tr,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: FONT_NAME2,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            MaterialIconButton(
                              mColor: colorAccent,
                              margin: EdgeInsets.all(16),
                              height: 45.0,
                              width: double.infinity,
                              circle: 8.0,
                              mChild: Container(
                                child: Text(
                                  'login'.tr,
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

                                if (username != '' && password != '') {
                                  authController.login(username, password);
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
                            MaterialIconButton(
                              mColor: colorAccent,
                              margin: EdgeInsets.all(16),
                              height: 45.0,
                              width: double.infinity,
                              circle: 8.0,
                              mChild: Container(
                                child: Text(
                                  'register_account'.tr,
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                              onClicked: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationScreen(),
                                  ),
                                );
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

  Future<bool> _onBackPressed() async {
    if (stateForExit == 0) {
      showColoredToast("Press again to exit the app");
      ++stateForExit;
      Duration sec = Duration(seconds: 3);
      Future.delayed(sec, () {
        stateForExit = 0;
      });
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }

    return false;
  }
}
