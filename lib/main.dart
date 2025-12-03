import 'dart:io';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/common/shared_pref_key.dart';
import 'package:my_cmh_updated/config/app_config.dart';
import 'package:my_cmh_updated/services/network_service.dart';
import 'package:my_cmh_updated/ui/auth/forgot_screen.dart';
import 'package:my_cmh_updated/ui/auth/login_screen.dart';
import 'package:my_cmh_updated/ui/dashboard/more/PdfScreen.dart';
import 'package:my_cmh_updated/ui/desk/desk_info_view.dart';
import 'package:my_cmh_updated/localize/app_labels.dart';
import 'package:my_cmh_updated/ui/payment/pay_bill_updated_view.dart';
import 'package:my_cmh_updated/ui/payment/pay_bill_view.dart';
import 'package:my_cmh_updated/ui/splash_screen.dart';
import 'package:my_cmh_updated/utils/app_info_utils.dart';
import 'package:my_cmh_updated/utils/surjopay_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shurjopay/utilities/functions.dart';

import 'ui/dashboard/health_records_screen.dart';
import 'localize/localization_service.dart';

Future<void> main() async {
  initializeShurjopay(environment: "live");
  //initializeShurjopay(environment: "sandbox");
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: colorAccent,
      systemNavigationBarColor: colorAccent,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  // AppConfig.setEnvironment(
  //     kReleaseMode ? Environment.production : Environment.development);

  _initializePaymentService();
  // Smooth Chucker is configured in each service class with SmoothChuckerDioInterceptor
  ChuckerFlutter.showOnRelease = false;
  AppConfig.setEnvironment(Environment.production);
  AppConfig.printEnvironmentInfo();
  await AppInfoUtil.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();

  // Initialize NetworkService
  Get.put(NetworkService());

  runApp(MyHomePage());
}

Future<void> _initializePaymentService() async {
  // Define your custom credentials
  const sandboxCredentials = PaymentCredentials(
    prefix: "NOK",
    userName: "sp_sandbox",
    password: "pyyk97hu&6u6",
    clientIP: "127.0.0.1",
    returnURL: "https://www.sandbox.shurjopayment.com/return_url",
    cancelURL: "https://www.sandbox.shurjopayment.com/cancel_url",
  );

  const productionCredentials = PaymentCredentials(
    prefix: "CMHD",
    userName: "cmh_dhaka",
    password: "cmh_m9wnzbjc6ss&",
    clientIP: "103.159.218.34",
    returnURL: "https://www.engine.shurjopayment.com/return_url",
    cancelURL: "https://www.engine.shurjopayment.com/cancel_url",
  );

  // Initialize the service
  ShurjoPayService.instance.initialize(
    environment:
        PaymentEnvironment.production, // Change to production when ready
    sandboxCredentials: sandboxCredentials,
    productionCredentials: productionCredentials,
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setLanguage() async {
    final SharedPreferences prefs = await _prefs;
    String language = prefs.getString(SharedPreferenceKeys.language) == 'Bangla'
        ? AppLabels.bangla
        : prefs.getString(SharedPreferenceKeys.language) == 'English'
        ? AppLabels.english
        : AppLabels.english;

    if (language == AppLabels.english) {
      Get.updateLocale(const Locale('en', 'US'));
    } else if (language == AppLabels.bangla) {
      Get.updateLocale(const Locale('bn', 'BD'));
    }
  }

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(colorAccent);
    //FlutterStatusbarcolor.setNavigationBarColor(colorStatusBar);
    return GetMaterialApp(
      builder: (context, child) {
        return SafeArea(
          top: false, // Set to true if you want to avoid the notch area as well
          bottom: true, // Prevents overlap with the system navigation bar
          child: child!,
        );
      },
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorPrimary,
        //accentColor: colorAccent,
        //backgroundColor: cBackgroundCommon,
        scaffoldBackgroundColor: cBackgroundCommon,
      ),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: LocalizationService.locales,
      navigatorObservers: [ChuckerFlutter.navigatorObserver],
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PdfScreen.id: (context) => PdfScreen(),
        ForgotPassScreen.id: (context) => ForgotPassScreen(),
        HealthRecordsScreen.id: (context) => HealthRecordsScreen(),
        DeskInfoScreen.id: (context) => DeskInfoScreen(),
        PayBillScreen.id: (context) => PayBillScreen(),
        PayBillViews.id: (context) => PayBillViews(),
      },
      onInit: () async {
        setLanguage();
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
