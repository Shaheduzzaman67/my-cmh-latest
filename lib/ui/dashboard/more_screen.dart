import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/ui/dashboard/more/PdfScreen.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Material(
            shadowColor: Color(0xFFE9E9E9).withOpacity(0.7),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            elevation: 8,
            child: Container(
              child: ListTile(
                title: Text(
                  'more'.tr,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: FONT_NAME,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                leading: ImageIcon(
                  AssetImage("images/more.png"),
                  size: 30,
                  color: colorPrimary,
                ),
              ),
            ),
          ),

          SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              elevation: 4,
              color: colorPrimary,
              child: Container(
                height: 55,
                child: Center(
                  child: ListTile(
                    title: Text(
                      'how_to_use'.tr,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 17.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    leading: ImageIcon(
                      AssetImage("images/about.png"),
                      size: 28,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, PdfScreen.id);
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    elevation: 4,
                    color: colorPrimary,
                    child: Container(
                      height: 100,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              child: Center(
                                child: Text(
                                  'current_version'.tr,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Material(
                                elevation: 0,
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      '1.0.0',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    elevation: 4,
                    color: colorPrimary,
                    child: Container(
                      height: 100,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              child: Center(
                                child: Text(
                                  'app_size'.tr,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Material(
                                elevation: 0,
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      '40 MB',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    elevation: 4,
                    color: colorPrimary,
                    child: Container(
                      height: 100,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              child: Center(
                                child: Text(
                                  'permission_details'.tr,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Material(
                                elevation: 0,
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      'Camera, Microphone',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    elevation: 4,
                    color: colorPrimary,
                    child: Container(
                      height: 100,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              child: Center(
                                child: Text(
                                  Platform.isIOS
                                      ? 'iOS Version'
                                      : 'Android Version',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Material(
                                elevation: 0,
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      Platform.isIOS
                                          ? '12.0 & above'
                                          : '5.1 & above',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Material(
          //     shadowColor: Colors.grey.withOpacity(0.5),
          //     borderRadius: BorderRadius.circular(8),
          //     elevation: 1,
          //     color: colorPrimary,
          //     child: Container(
          //       height: 120,
          //       child: Center(
          //         child: Column(
          //           children: [
          //             Container(
          //               height: 30,
          //               child: Center(
          //                 child: Text(
          //                   'any_query'.tr,
          //                   style: GoogleFonts.nunitoSans(
          //                       fontSize: 14.0,
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.w600),
          //                 ),
          //               ),
          //             ),
          //             Expanded(
          //               child: Material(
          //                 elevation: 0,
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.only(
          //                     bottomLeft: Radius.circular(8),
          //                     bottomRight: Radius.circular(8)),
          //                 child: Container(
          //                   width: MediaQuery.of(context).size.width,
          //                   child: Center(
          //                     child: GestureDetector(
          //                       onTap: (){
          //                         _launchEmail();
          //                       },
          //                       child: Text(
          //                         'email_at'.tr,
          //                         style: GoogleFonts.nunitoSans(
          //                             fontSize: 18.0,
          //                             color: Colors.black,
          //                             fontWeight: FontWeight.w600),
          //                         textAlign: TextAlign.center,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  // void _launchEmail() async {
  //   List<String> to = ['support@tilbd.net'];
  //   List<String> cc = [''];
  //   List<String> bcc = [];
  //   String subject = '';
  //   String body = '';

  //   Email email = Email(to: to, cc: cc, bcc: bcc, subject: subject, body: body);
  //   await EmailLauncher.launch(email);
  // }
}
