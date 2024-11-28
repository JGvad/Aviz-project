import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Feature/DetialPromotion/view/detial_promotion_screen.dart';
import 'package:aviz/Feature/Home/bloc/bloc/home_bloc.dart';
import 'package:aviz/Feature/ListPromotion/view/promotion_list_screen.dart';
import 'package:aviz/Widgets/animation_loading.dart';
import 'package:aviz/Widgets/empty_content_widget.dart';
import 'package:aviz/Widgets/hot_promotion_widget.dart';
import 'package:aviz/Widgets/lastest_promotion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: AppColor.white,
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return AnimationLoding.threeBounce();
              } else if (state is HomeListResponse) {
                return CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      title: Transform.scale(
                        scale: 1.3,
                        child: SvgPicture.asset(AppSvg.logoWithNotBackground),
                      ),
                      centerTitle: true,
                      backgroundColor: AppColor.white,
                      automaticallyImplyLeading: false,
                    ),
                    state.getHotPrmotions.fold(
                      (exception) {
                        return SliverToBoxAdapter(
                          child: Text(exception),
                        );
                      },
                      (hotPromotions) {
                        return SliverToBoxAdapter(
                          child: _HeaderPromotion(
                            title: 'آویزهای داغ',
                            promotionList: hotPromotions.reversed.toList(),
                          ),
                        );
                      },
                    ),
                    state.getHotPrmotions.fold(
                      (exception) {
                        return SliverToBoxAdapter(child: Text(exception));
                      },
                      (hotPromotions) {
                        return SliverToBoxAdapter(
                          child: _buildHotPromotion(
                            hotPrmotionList: hotPromotions.reversed.toList(),
                          ),
                        );
                      },
                    ),
                    state.getLastestPrmotions.fold(
                      (exception) {
                        return SliverToBoxAdapter(
                          child: Text(exception),
                        );
                      },
                      (lastestPromotions) {
                        return SliverToBoxAdapter(
                          child: _HeaderPromotion(
                            title: 'آویزهای اخیر',
                            promotionList: lastestPromotions.reversed.toList(),
                          ),
                        );
                      },
                    ),
                    state.getLastestPrmotions.fold(
                      (exception) {
                        return SliverToBoxAdapter(
                          child: Text(exception),
                        );
                      },
                      (lastestPromotions) {
                        return _buildLastestPromotionList(
                          lastestPromotionList:
                              lastestPromotions.reversed.toList(),
                        );
                      },
                    ),
                  ],
                );
              }
              return EmptyContent(
                title: 'مشکلی پیش امده !',
                widget: SvgPicture.asset(AppSvg.infoAppIcon),
              );
            },
          ),
        ),
      ),
    );
  }

  SliverList _buildLastestPromotionList(
      {required List<PromotionModel> lastestPromotionList}) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetialPromotionScreen(
                    prmotion: lastestPromotionList[index],
                  ),
                ),
              );
            },
            child: LastestPromotionCard(
              promotion: lastestPromotionList[index],
            ),
          ),
        ),
        childCount: lastestPromotionList.length,
      ),
    );
  }

  SizedBox _buildHotPromotion({required List<PromotionModel> hotPrmotionList}) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetialPromotionScreen(
                      prmotion: hotPrmotionList[index],
                    ),
                  ),
                );
              },
              child: HotPromotionCard(
                promotion: hotPrmotionList[index],
              ),
            ),
          );
        },
        itemCount: hotPrmotionList.length,
      ),
    );
  }
}

class _HeaderPromotion extends StatelessWidget {
  const _HeaderPromotion({
    required String title,
    required this.promotionList,
  }) : _titleHeader = title;

  final String _titleHeader;
  final List<PromotionModel> promotionList;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
          top: 32,
          bottom: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _titleHeader,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PromotionListScreen(
                    title: _titleHeader,
                    promotionList: promotionList,
                  ),
                ),
              ),
              child: Text(
                'مشاهده همه',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
