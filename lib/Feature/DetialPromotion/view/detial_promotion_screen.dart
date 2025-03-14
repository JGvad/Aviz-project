import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Di/di.dart';
import 'package:aviz/Feature/Dashboard/view/dashboard_screen.dart';
import 'package:aviz/Feature/DetialPromotion/bloc/bloc/detial_promotion_bloc.dart';
import 'package:aviz/Feature/DetialPromotion/view/component/desciption_component.dart';
import 'package:aviz/Feature/DetialPromotion/view/component/detial_tab_horizental_component.dart';
import 'package:aviz/Feature/DetialPromotion/view/component/facilities_component.dart';
import 'package:aviz/Feature/DetialPromotion/view/component/price_component.dart';
import 'package:aviz/Feature/DetialPromotion/view/component/specifications_component.dart';
import 'package:aviz/Feature/Profile/bloc/bloc/profile_bloc.dart';
import 'package:aviz/Util/created_time_promotion.dart';
import 'package:aviz/Util/result_massage.dart';
import 'package:aviz/UtilNetwork/auth_management.dart';
import 'package:aviz/Widgets/cheched_image_widget.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetialPromotionScreen extends StatelessWidget {
  DetialPromotionScreen(
      {super.key, required this.prmotion, this.isSaved = false});
  final ValueNotifier<int> _selectedSegment = ValueNotifier(0);
  final PromotionModel prmotion;
  final bool isSaved;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<DetialPromotionBloc>(),
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocProvider.value(
            value: locator.get<ProfileBloc>(),
            child: BlocListener<DetialPromotionBloc, DetialPromotionState>(
              listener: (context, state) {
                if (state is DetialPromotionSaveResponse) {
                  return state.result.fold(
                    (exception) {
                      return ResultMassanger.customSnackBar(
                          message: 'به ذخیره ها اضافه نشد', context: context);
                    },
                    (ok) async {
                      String? userId = await AuthManagement.readUserId();
                      if (!context.mounted) return;

                      ResultMassanger.customSnackBar(
                          message: 'به ذخیره ها اضافه شد', context: context);
                      context
                          .read<ProfileBloc>()
                          .add(ProfileFetchData(userId: userId));
                    },
                  );
                }
              },
              child: Scaffold(
                backgroundColor: AppColor.white,
                appBar: _buildAppBar(context),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageContainer(context),
                      _buildInfoRow(context),
                      _buildTitle(context),
                      _buildDashedLine(),
                      _buildWarningTile(context),
                      ValueListenableBuilder(
                        valueListenable: _selectedSegment,
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              DetialTabHorizentalComponent(
                                selectedSegment: _selectedSegment,
                              ),
                              _getSelectedComponent(),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ),
          ),
          child: SvgPicture.asset(AppSvg.arrowRightIcon),
        ),
      ),
      actions: [
        _buildAppBarIcon(AppSvg.informationIcon, () {}),
        _buildAppBarIcon(AppSvg.shareIcon, () {}),
        BlocBuilder<DetialPromotionBloc, DetialPromotionState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(left: 17, right: 8),
              child: GestureDetector(
                onTap: () async {
                  if (!context.mounted) return;
                  context
                      .read<DetialPromotionBloc>()
                      .add(DetialPromotionSaveData(prmotion));
                },
                child: isSaved
                    ? SvgPicture.asset(AppSvg.saveIcon,
                        // ignore: deprecated_member_use
                        color: AppColor.red)
                    : SvgPicture.asset(
                        AppSvg.saveIcon,
                        // ignore: deprecated_member_use
                        color: state is DetialPromotionSaveResponse &&
                                state.result.isRight()
                            ? AppColor.red
                            : AppColor.black,
                      ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAppBarIcon(String asset, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SvgPicture.asset(asset),
    );
  }

  Widget _buildImageContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 163,
      margin: const EdgeInsets.symmetric(vertical: 34),
      child: CachedImage(
        imageUrl: prmotion.thumbnailUrl,
        raduis: 4,
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 29,
          decoration: BoxDecoration(
            color: AppColor.lightGrey1,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              prmotion.nameSubCategory,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AppColor.red),
            ),
          ),
        ),
        const Spacer(),
        createdTimePrmotion(),
      ],
    );
  }

  FutureBuilder<String> createdTimePrmotion() {
    return FutureBuilder<String>(
      future: CreatedAtPromotion.createdTime(prmotion.creatTime),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitPulse(
            size: 20,
            color: AppColor.red,
          );
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return Text(
            '${snapshot.data!} ${prmotion.location}',
            style: Theme.of(context).textTheme.headlineMedium!,
          );
        }
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Text(
        prmotion.description,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }

  Widget _buildDashedLine() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: DottedDashedLine(
        height: 0,
        width: double.infinity,
        axis: Axis.horizontal,
        dashColor: AppColor.lightGrey1,
      ),
    );
  }

  Widget _buildWarningTile(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 1, color: AppColor.lightGrey1),
      ),
      child: ListTile(
        title: Text(
          'هشدار های قبل از معامله!',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
        ),
        trailing: SvgPicture.asset(AppSvg.arrowLeftIcon),
        onTap: () => _showWarningBottomSheet(context),
      ),
    );
  }

  void _showWarningBottomSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: AppColor.white,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'روش‌های رایج کلاهبرداری شامل موارد زیر هستند:\nدریافت بیعانه\nدریافت پول به بهانهٔ هزینهٔ ارسال\nتحویل کالای تقلبی یا معیوب\nدرخواست اطلاعات بانکی یا هویتی\nدرخواست «کد تأییدِ ۶ رقمی ورود به حساب آویز\nدر این موارد به شدت احتیاط کنید: آگهی‌گذار درخواست بیعانه دارد، قیمت کالا پایین و وسوسه‌کننده است، آگهی‌گذار معاملهٔ حضوری را رد می‌کند، و آگهی‌گذار به جای چت دیوار، مکالمه در خارج دیوار را پیشنهاد می‌کند.',
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.rtl,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppColor.black,
                        height: 2,
                      ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getSelectedComponent() {
    switch (_selectedSegment.value) {
      case 0:
        return SpecificationsComponent(promotion: prmotion);
      case 1:
        return PriceComponent(promotion: prmotion);
      case 2:
        return FacilitiesComponent(
          promotion: prmotion,
        );
      default:
        return DesciptionComponent(
          promotion: prmotion,
        );
    }
  }
}
