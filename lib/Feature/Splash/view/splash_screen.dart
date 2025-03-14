import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Feature/Authentication/view/auth_login_screen.dart';
import 'package:aviz/Feature/Authentication/view/auth_register_screen.dart';
import 'package:aviz/Feature/Splash/view/component/page_view_content_component.dart';
import 'package:aviz/Widgets/double_buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColor.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      _pageViewContent(),
                      _smoothPage(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DoubleBottomWidget(
                    firstTitle: 'ثبت نام',
                    onTapFirst: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthRegisterScreen(),
                      ),
                    ),
                    secendTitle: 'ورود',
                    onTapSecend: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthLoginScreen(),
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

  Positioned _smoothPage() {
    return Positioned(
      bottom: 32,
      child: SmoothPageIndicator(
        controller: _pageController,
        count: 1,
        effect: ExpandingDotsEffect(
          dotColor: AppColor.textColor,
          dotHeight: 7,
          dotWidth: 7,
          expansionFactor: 2,
          activeDotColor: AppColor.red,
        ),
      ),
    );
  }

  PageView _pageViewContent() {
    return PageView(
      controller: _pageController,
      children: const [
        PageViewContentComponent(
          image: 'assets/images/welcome_image.png',
          title: 'اینجا محل آویز اگهی شماست',
          description:
              'در آویز ملک خود را برای فروش،اجاره و رهن آگهی کنید و یا اگر دنبال ملک با مشخصات دلخواه خود هستید آویز ها را ببینید',
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
