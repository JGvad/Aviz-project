import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Core/data/models/promotion_hive_model.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Di/di.dart';
import 'package:aviz/Feature/DetialPromotion/view/detial_promotion_screen.dart';
import 'package:aviz/Feature/ListPromotion/bloc/bloc/list_promotion_bloc.dart';
import 'package:aviz/Feature/Profile/bloc/bloc/profile_bloc.dart';
import 'package:aviz/Util/result_massage.dart';
import 'package:aviz/UtilNetwork/auth_management.dart';
import 'package:aviz/UtilNetwork/promotion_mapper.dart';
import 'package:aviz/Widgets/empty_content_widget.dart';
import 'package:aviz/Widgets/lastest_promotion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PromotionListScreen extends StatelessWidget {
  const PromotionListScreen({
    super.key,
    required this.title,
    this.promotionList,
    this.savedPromotion,
    this.isSavedPromotion = false,
  });
  final String title;
  final bool isSavedPromotion;

  final List<SavedPromotion>? savedPromotion;
  final List<PromotionModel>? promotionList;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<ListPromotionBloc>(),
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            backgroundColor: AppColor.white,
            appBar: _buildAppBar(context),
            body: BlocListener<ListPromotionBloc, ListPromotionState>(
              listener: (context, state) {
                if (state is ListPromotionSavedDeleteResponse) {
                  return state.result.fold(
                    (exception) => ResultMassanger.customSnackBar(
                      context: context,
                      message: exception,
                      color: AppColor.red,
                    ),
                    (response) => ResultMassanger.customSnackBar(
                        message: response, context: context),
                  );
                }
              },
              child: Center(
                child: _buildContent(isSavedPromotion),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isSavePromotion) {
    if (isSavePromotion) {
      return _buildSavedPromotions();
    } else {
      return _buildPromotions();
    }
  }

  Widget _buildSavedPromotions() {
    if (savedPromotion == null || savedPromotion!.isEmpty) {
      return EmptyContent(
        title: 'هنوز هیچ اگهی برات جلب توجه نکرده !',
        widget: SvgPicture.asset(AppSvg.infoAppIcon),
      );
    }

    return BlocProvider.value(
      value: locator.get<ProfileBloc>(),
      child: ListView.builder(
        itemCount: savedPromotion!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetialPromotionScreen(
                      isSaved: true,
                      prmotion: PromotionMapper.fromSavedPromotion(
                        savedPromotion![index],
                      ),
                    ),
                  ),
                );
              },
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) async {
                  String? userid = await AuthManagement.readUserId();
                  if (!context.mounted) return;
                  context.read<ListPromotionBloc>().add(
                        DeletSavedPromotionList(index),
                      );
                  context.read<ProfileBloc>().add(
                        ProfileFetchData(userId: userid),
                      );
                },
                child: LastestPromotionCard(
                  savedPromotion: savedPromotion![index],
                  isSavedPromotion: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromotions() {
    if (promotionList == null || promotionList!.isEmpty) {
      return EmptyContent(
        title: 'هنوز افتخار به ثبت اگهی ندادی !',
        widget: SvgPicture.asset(AppSvg.exclamationPointIcon),
      );
    }

    return BlocProvider.value(
      value: locator.get<ProfileBloc>(),
      child: ListView.builder(
        itemCount: promotionList!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetialPromotionScreen(
                      prmotion: promotionList![index],
                    ),
                  ),
                );
              },
              child: LastestPromotionCard(
                promotion: promotionList![index],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 3,
      automaticallyImplyLeading: false,
      shadowColor: AppColor.lightGrey1,
      backgroundColor: AppColor.white,
      surfaceTintColor: Colors.transparent,
      title: Transform.scale(
        scale: 1.1,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColor.red,
              ),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: SvgPicture.asset(AppSvg.arrowRightIcon),
          onPressed: () => Navigator.pop(context),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    );
  }
}
