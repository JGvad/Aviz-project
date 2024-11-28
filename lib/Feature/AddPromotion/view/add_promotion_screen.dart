import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Di/di.dart';
import 'package:aviz/Feature/AddPromotion/bloc/bloc/add_promotion_bloc.dart';
import 'package:aviz/Feature/AddPromotion/data/model/sub_category_model.dart';
import 'package:aviz/Feature/AddPromotion/data/model/temporary_promotion_model.dart';
import 'package:aviz/Feature/AddPromotion/view/component/confirm_promotion_component.dart';
import 'package:aviz/Feature/AddPromotion/view/component/categoray_promotion_component.dart';
import 'package:aviz/Feature/AddPromotion/view/component/peroperty_promotion_component.dart';
import 'package:aviz/Feature/AddPromotion/view/component/location_promotion_component.dart';
import 'package:aviz/Feature/Dashboard/view/dashboard_screen.dart';
import 'package:aviz/Feature/Home/bloc/bloc/home_bloc.dart';
import 'package:aviz/Feature/Home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AddPromotionScreen extends StatefulWidget {
  const AddPromotionScreen({super.key});

  @override
  State<AddPromotionScreen> createState() => _AddPromotionScreenState();
}

class _AddPromotionScreenState extends State<AddPromotionScreen> {
  final ValueNotifier<double> _currentStep = ValueNotifier(0.0);
  late PageController _pageController;
  final int _totalSteps = 5;
  final ValueNotifier<List<SubCategoryModel>> _subCategoryList =
      ValueNotifier<List<SubCategoryModel>>([]);
  final ValueNotifier<String> _subCateSelectedName = ValueNotifier<String>('');
  final ValueNotifier<String> _subCateSelectedId = ValueNotifier<String>('');

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
          appBar: _buildAppBar(context),
          body: Column(
            children: [
              _buildProgressIndicator(context),
              const SizedBox(height: 24),
              Expanded(
                child: BlocBuilder<AddPromotionBloc, AddPromotionState>(
                  builder: (context, state) {
                    return PageView(
                      controller: _pageController,
                      children: [
                        if (state is AddPromotionCategoryResponse) ...{
                          state.categoryList.fold(
                            (exception) {
                              return Text(exception);
                            },
                            (categpries) {
                              return ListView.builder(
                                itemCount: categpries.length,
                                itemBuilder: (context, index) {
                                  return CategorayItem(
                                    title: categpries[index].name,
                                    onNext: () => _nextPage(
                                      categoryId: categpries[index].id,
                                      context: context,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        },
                        if (state is AddPromotionSubCategoryResponse) ...{
                          state.subcategoryList.fold(
                            (exception) {
                              return Text(exception);
                            },
                            (subCategpries) {
                              return ListView.builder(
                                itemCount: subCategpries.length,
                                itemBuilder: (context, index) {
                                  return CategorayItem(
                                    title: subCategpries[index].name,
                                    onNext: () => _nextPage(
                                      subCategpries: subCategpries,
                                      index: index,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder<List<SubCategoryModel>>(
                            valueListenable: _subCategoryList,
                            builder: (context, subCategoryList, child) {
                              return ValueListenableBuilder<String>(
                                valueListenable: _subCateSelectedName,
                                builder: (context, subCateSelected, child) {
                                  return ValueListenableBuilder(
                                    valueListenable: _subCateSelectedId,
                                    builder:
                                        (context, subCateSelectedId, child) {
                                      return PropertyPromotionComponent(
                                        onNext: _nextPage,
                                        subCateId: _subCateSelectedId,
                                        subCateName: _subCateSelectedName,
                                        subCategotyList: subCategoryList,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          LocationPromotionComponent(onNext: _nextPage),
                          BlocProvider.value(
                            value: locator.get<AddPromotionBloc>(),
                            child: BlocProvider.value(
                              value: locator.get<HomeBloc>(),
                              child: const ConfirmPromotionConponent(),
                            ),
                          ),
                        },
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(' دسته بندی'),
          SvgPicture.asset(AppSvg.logoImage),
        ],
      ),
      titleTextStyle:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColor.red),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => _previousPageOrNavigateHome(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SvgPicture.asset(AppSvg.arrowRightIcon),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            TemporaryPromotionModel.instance.clear();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset(AppSvg.closeIcon),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _currentStep,
      builder: (context, value, child) {
        return LinearPercentIndicator(
          width: MediaQuery.of(context).size.width,
          lineHeight: 4.0,
          percent: value,
          backgroundColor: AppColor.white,
          progressColor: AppColor.red,
          animationDuration: 500,
          barRadius: const Radius.circular(10),
          isRTL: true,
        );
      },
    );
  }

  void _nextPage(
      {String? categoryId, BuildContext? context, subCategpries, index}) {
    if (_currentStep.value == 0.25) {
      _subCateSelectedName.value = subCategpries[index].name;
      _subCategoryList.value = subCategpries;
      _subCateSelectedId.value = subCategpries[index].id;
    }
    if (_currentStep.value < 1.0) {
      _currentStep.value += 1 / (_totalSteps - 1);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }

    if (categoryId != null && context != null) {
      context
          .read<AddPromotionBloc>()
          .add(AddPromotionSubCategoryRequest(categoryId));
    }
  }

  void _previousPageOrNavigateHome(BuildContext context) {
    if (_currentStep.value > 0) {
      _currentStep.value -= 1 / (_totalSteps - 1);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      TemporaryPromotionModel.instance.clear();
      if (_currentStep.value == 0.25) {
        setState(
          () {
            final addPromotionBloc = locator.get<AddPromotionBloc>();
            addPromotionBloc.add(AddPromotionCategoryRequest());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: addPromotionBloc,
                  child: const AddPromotionScreen(),
                ),
              ),
            );
          },
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentStep.dispose();
    super.dispose();
  }
}
