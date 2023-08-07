import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onboarding_concept/data/config/app_config.dart';

import 'ui/utils/helpers/providers.dart';
import 'ui/view/lading/landing_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await AppConfig.init();

  runApp(AppProviders(
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Thuyen vien',
          theme: ThemeData(fontFamily: 'Inter').copyWith(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white,
            // useMaterial3: true,
          ),
          //getPages: AppPages.routes,
          navigatorKey: navigatorKey,
          home: const LandingPage())));
}
