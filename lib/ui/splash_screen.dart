import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/common/sessions.dart';
import 'package:my_cmh_updated/model-new/user_info_response.dart';
import 'package:my_cmh_updated/services/network_service.dart';
import 'package:my_cmh_updated/ui/auth/login_screen.dart';
import 'package:my_cmh_updated/ui/dash_board_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  static String id = '/SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NetworkService _networkService = Get.find<NetworkService>();
  var accessToken = '';
  var patientName = <Item>[];
  var allUserList = <Item>[];

  Future<void> checkConnectivityAndProceed() async {
    // Wait for NetworkService to initialize
    await Future.delayed(Duration(milliseconds: 100));

    // Listen to network changes
    ever(_networkService.isConnected, (bool connected) {
      if (connected) {
        // If connected, proceed to next screen
        nextScreen();
      }
    });

    // Check initial connection
    if (!_networkService.isConnected.value) {
      // If no connection, NetworkService will show the dialog
      // We just need to wait for connection
      debugPrint('No internet connection detected');
    } else {
      // If connected, proceed to next screen
      nextScreen();
    }
  }

  nextScreen() async {
    var userId = await Session.shared.getUserId();
    if (userId != null && userId != '') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashBoardScreen()),
      );
    } else {
      Navigator.popAndPushNamed(context, LoginScreen.id);
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnectivityAndProceed();
  }

  @override
  void didUpdateWidget(SplashScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
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
                color: Color(0xFFFFFFFF).withOpacity(0.3),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage('images/logo.png'),
                        width: 220.0,
                      ),
                    ),
                    SizedBox(height: 80),
                    Container(
                      margin: EdgeInsets.only(left: 32.0, right: 32.0),
                      child: Text(
                        "Powered by\nAHQ, GS Br, IT Dte.\nCommitted to secured connectivity and satisfaction of users.",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 18.0,
                          color: colorAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 120.0,
                left: 0.0,
                right: 0.0,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
