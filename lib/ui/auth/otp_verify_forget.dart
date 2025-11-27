import 'dart:async';

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/model-new/password_change_request.dart';
import 'package:my_cmh_updated/services/networking.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPinCodeVerificationScreen extends StatefulWidget {
  final String personalNumber;
  ForgetPinCodeVerificationScreen(this.personalNumber);

  @override
  _ForgetPinCodeVerificationScreenState createState() =>
      _ForgetPinCodeVerificationScreenState();
}

class _ForgetPinCodeVerificationScreenState
    extends State<ForgetPinCodeVerificationScreen> {
  var onTapRecognizer;

  var username = '';

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  var _saving = false;

  Future<void> otpVerification() async {
    setState(() {
      _saving = true;
    });
    NetworkHelper networkHelper = NetworkHelper();

    var req = PasswordChangeRequest();

    req.personalNumber = widget.personalNumber.toUpperCase();
    req.otp = textEditingController.text;
    req.password = username;

    await networkHelper.passwordChange(req).then((result) async {
      setState(() {
        _saving = false;
      });
      if (result != null && result.success == true) {
        showDialog(
          useRootNavigator: false,
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new AlertDialog(
              titlePadding: EdgeInsets.all(0.0),
              title: Container(
                color: colorAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    ''.tr,
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              content: new Text(
                'pass_change_successful'.tr,
                style: GoogleFonts.barlowSemiCondensed(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: colorPrimary,
                ),
              ),
              actions: <Widget>[
                new TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: new Text(
                    'login'.tr,
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          buildAlertDialogWithChildren(
            context,
            true,
            'information'.tr,
            result.message ?? 'went_wrong'.tr,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      key: scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
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
            SizedBox(height: 150),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'otp_verification'.tr,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 8,
              ),
              child: RichText(
                text: TextSpan(
                  text: "enter_code_on_mobile".tr,
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 30,
                ),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "otp_limit".tr;
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: Colors.green.shade300,
                    inactiveFillColor: Colors.green.shade300,
                    activeFillColor: hasError ? Colors.orange : Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    ),
                  ],
                  onCompleted: (v) {},
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextField(
                onChanged: (value) {
                  username = value;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                autofillHints: [AutofillHints.password],
                textAlign: TextAlign.start,
                obscureText: true,
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
                  hintText: 'enter_password'.tr,
                  icon: Icon(Icons.password, color: colorAccent),
                  border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                hasError ? "enter_otp_error".tr : "",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 30,
              ),
              child: ButtonTheme(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    formKey.currentState!.validate();
                    if (currentText.length != 4) {
                      errorController!.add(ErrorAnimationType.shake);
                      setState(() {
                        hasError = true;
                      });
                    } else {
                      if (username != '') {
                        otpVerification();
                      } else {
                        buildAlertDialogWithChildren(
                          context,
                          true,
                          'information'.tr,
                          'required_data'.tr,
                        );
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      "change_password".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade300,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade200,
                    offset: Offset(1, -2),
                    blurRadius: 5,
                  ),
                  BoxShadow(
                    color: Colors.green.shade200,
                    offset: Offset(-1, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
