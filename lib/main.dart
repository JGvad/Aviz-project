import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Core/data/models/promotion_hive_model.dart';
import 'package:aviz/Di/di.dart';
import 'package:aviz/Feature/Authentication/view/auth_login_screen.dart';
import 'package:aviz/Feature/Dashboard/view/dashboard_screen.dart';
import 'package:aviz/Feature/Splash/view/splash_screen.dart';
import 'package:aviz/UtilNetwork/auth_management.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SavedPromotionAdapter());
  await Hive.openBox<SavedPromotion>('SavedBox');
  serviceLocator();
  bool isLogin = await AuthManagement.isLogin();
  bool checkFirstTime = await AuthManagement.checkFirstTime();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => AvizeApp(
        isLogin: isLogin,
        isFistTime: checkFirstTime,
      ),
    ),
  );
}

class AvizeApp extends StatelessWidget {
  const AvizeApp({super.key, required this.isLogin, required this.isFistTime});
  final bool isLogin;
  final bool isFistTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 14,
            fontFamily: 'SM',
            fontWeight: FontWeight.w400,
            color: AppColor.textGery,
          ),
          headlineLarge: TextStyle(
            fontSize: 16,
            fontFamily: 'SM',
            fontWeight: FontWeight.w700,
            color: AppColor.black,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontFamily: 'SM',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: isFistTime
          ? const SplashScreen()
          : isLogin
              ? const DashboardScreen()
              : const AuthLoginScreen(),
    );
  }
}
