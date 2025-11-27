import 'package:get/get.dart';

import 'package:my_cmh_updated/common/sessions.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/custom_widgets/MateriaIconButton.dart';
import 'package:my_cmh_updated/model-new/feedback_request.dart';
import 'package:my_cmh_updated/model-new/user_info_response.dart';
import 'package:my_cmh_updated/services/networking.dart';
import 'package:my_cmh_updated/ui/bmi/Screens/input_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/ui/dash_board_screen.dart';
import 'package:my_cmh_updated/ui/dashboard/health_records_screen.dart';
import 'package:my_cmh_updated/ui/desk/desk_info_view.dart';
import 'package:my_cmh_updated/ui/payment/pay_bill_updated_view.dart';
import 'package:my_cmh_updated/ui/payment/pay_bill_view.dart';
import 'package:my_cmh_updated/ui/widget/shimmer_line_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var authController = GetControllers.shared.getAuthController();

  var userDataModel = <Item>[];

  var _saving = false;

  var myChildSize = Size.zero;

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  Future<void> loadUserData() async {
    var personalId = await Session.shared.getUserId();
    await authController.getUserInfo(personalId);
  }

  Future<void> submitFeedback() async {
    setState(() {
      _saving = true;
    });

    NetworkHelper networkHelper = NetworkHelper();

    var req = FeedbackRequest();
    req.feedbackText = _feedbackController.text;
    req.personalNumber = authController.patientName[0].personalNumber;
    await networkHelper.submitFeedback(req).then((result) async {
      setState(() {
        _saving = false;
      });
      if (result != null && result.success == true) {
        _feedbackController.clear();
        buildAlertDialogWithChildren(
          context,
          true,
          'information'.tr,
          result.message!,
        );
      } else {
        buildAlertDialogWithChildren(
          context,
          true,
          'information'.tr,
          result.message!,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 5, right: 5, top: 20),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: <Widget>[
              !(authController.isDataLoaded.value)
                  ? ShimmerLineItem()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('images/user2.png'),
                            height: 40,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              '${authController.patientName[0].patientName ?? ''}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontFamily: FONT_NAME,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              DashBoardScreen.of(
                                context,
                              )?.controller.jumpToPage(1);
                              DashBoardScreen.of(context)?.currentIndex = 1;
                            },
                            child: item(
                              name: "doctors_appointment".tr,
                              image: 'images/appoint.png',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        //Spacer(),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              DashBoardScreen.of(
                                context,
                              )?.controller.jumpToPage(2);
                              DashBoardScreen.of(context)?.currentIndex = 2;
                            },
                            child: item(
                              name: 'prescription'.tr,
                              image: 'images/prescription.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              DashBoardScreen.of(
                                context,
                              )?.controller.jumpToPage(3);
                              DashBoardScreen.of(context)?.currentIndex = 3;
                            },
                            child: item(
                              name: 'reports'.tr,
                              image: 'images/prescription.png',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                HealthRecordsScreen.id,
                              );
                            },
                            child: item(
                              name: "food_nu".tr,
                              image: 'images/nutrition.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InputPage(),
                                ),
                              );
                            },
                            child: item(
                              name: "bmi_calculator".tr,
                              image: 'images/calculator.png',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _showFeedbackDialog(context);
                            },
                            child: item(name: "feedback".tr),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, DeskInfoScreen.id);
                            },
                            child: item(
                              name: "help_desk".tr,
                              image: 'images/hospital-location.png',
                            ),
                          ),
                        ),
                        //Spacer(),
                        SizedBox(width: 10),
                        if (authController
                                .appVersionInfo
                                .value
                                .isPayAvailable ==
                            true)
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, PayBillViews.id);
                              },
                              child: item(name: "pay_bill".tr, isNew: true),
                            ),
                          )
                        else
                          Expanded(child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController _feedbackController = TextEditingController();

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'submit_feedback'.tr,
            style: GoogleFonts.nunitoSans(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(hintText: 'submit_feedback_hint'.tr),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _feedbackController.clear();
              },
              child: Text(
                'cancel'.tr,
                style: GoogleFonts.nunitoSans(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            MaterialIconButton(
              mColor: colorAccent,
              margin: EdgeInsets.all(16),
              height: 45.0,
              width: 100.0,
              circle: 8.0,
              mChild: Container(
                child: Text(
                  'submit'.tr,
                  style: GoogleFonts.nunitoSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              onClicked: () async {
                if (_feedbackController.text.isEmpty) {
                  buildAlertDialogWithChildren(
                    context,
                    false,
                    'information'.tr,
                    'required_data'.tr,
                  );
                  return;
                } else {
                  Navigator.of(context).pop();
                  submitFeedback();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget item({String? name, String? image, bool isNew = false}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            width: width * 0.53,
            height: height * 0.16,
            child: Image(
              image: AssetImage('images/regular.png'),
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          name!,
                          style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isNew)
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'New',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 8),
                  ),
                  if (image != null)
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Image(
                        image: AssetImage(image),
                        fit: BoxFit.contain,
                        width: 30,
                        height: 40,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
