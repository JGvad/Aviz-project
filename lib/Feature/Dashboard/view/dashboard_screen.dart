import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Di/di.dart';
import 'package:aviz/Feature/AddPromotion/bloc/bloc/add_promotion_bloc.dart';
import 'package:aviz/Feature/AddPromotion/view/add_promotion_screen.dart';
import 'package:aviz/Feature/Home/bloc/bloc/home_bloc.dart';
import 'package:aviz/Feature/Home/view/home_screen.dart';
import 'package:aviz/Feature/Profile/bloc/bloc/profile_bloc.dart';
import 'package:aviz/Feature/Profile/view/profile_screen.dart';
import 'package:aviz/Feature/Search/bloc/bloc/search_bloc.dart';
import 'package:aviz/Feature/Search/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ValueNotifier<int> iconSelected = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        await SystemNavigator.pop();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ValueListenableBuilder(
          valueListenable: iconSelected,
          builder: (context, value, child) {
            return Scaffold(
              body: IndexedStack(
                index: iconSelected.value,
                children: _screen, //////////////
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColor.customGrey,
                elevation: 0,
                selectedItemColor: AppColor.red,
                unselectedItemColor: AppColor.gery,
                selectedLabelStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w500),
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w500),
                currentIndex: iconSelected.value,
                onTap: (int index) {
                  iconSelected.value = index;
                },
                items: _navItems
                    .map((item) => _buildBottomNavigationBarItem(item))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<Widget> _screen = [
  BlocProvider.value(
    value: locator.get<HomeBloc>()
      ..add(
        HomeFetchData(),
      ),
    child: const HomeScreen(),
  ),
  BlocProvider(
    create: (context) => locator.get<SearchBloc>(),
    child: const SearchScreen(),
  ),
  BlocProvider(
    create: (context) {
      final bloc = locator.get<AddPromotionBloc>();
      bloc.add(
        AddPromotionCategoryRequest(),
      );
      return bloc;
    },
    child: const AddPromotionScreen(),
  ),
  BlocProvider<ProfileBloc>(
    create: (context) => locator.get<ProfileBloc>(),
    child: const ProfileScreen(),
  ),
];

class _NavItemData {
  final String label;
  final String outlineIcon;
  final String boldIcon;

  _NavItemData({
    required this.label,
    required this.outlineIcon,
    required this.boldIcon,
  });
}

final List<_NavItemData> _navItems = [
  _NavItemData(
    label: 'آویز اگهی ها',
    outlineIcon: AppSvg.normalHomeIcon,
    boldIcon: AppSvg.activeHomeIcon,
  ),
  _NavItemData(
    label: 'جستوجو',
    outlineIcon: AppSvg.normalSearchIcon,
    boldIcon: AppSvg.activeSearchIcon,
  ),
  _NavItemData(
    label: 'افزودن آویز',
    outlineIcon: AppSvg.normalAddIcon,
    boldIcon: AppSvg.activeAddIcon,
  ),
  _NavItemData(
    label: 'آویز من',
    outlineIcon: AppSvg.normalProfileIcon,
    boldIcon: AppSvg.normalProfileIcon,
  ),
];

BottomNavigationBarItem _buildBottomNavigationBarItem(_NavItemData item) {
  return BottomNavigationBarItem(
    label: item.label,
    icon: Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SvgPicture.asset(
        item.outlineIcon,
        width: 24,
        height: 24,
      ),
    ),
    activeIcon: Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: SvgPicture.asset(
        item.boldIcon,
        width: 24,
        height: 24,
        color: AppColor.red,
      ),
    ),
  );
}
