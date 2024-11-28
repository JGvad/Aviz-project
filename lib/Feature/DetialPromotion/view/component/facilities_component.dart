import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Feature/DetialPromotion/view/component/communication_component.dart';
import 'package:aviz/Widgets/header_component_widget.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';

class FacilitiesComponent extends StatelessWidget {
  const FacilitiesComponent({super.key, required this.promotion});
  final PromotionModel promotion;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          _buildHeader(),
          _buildFacilitiesTable(),
          CommunicationComponent(promotion: promotion)
        ],
      ),
    );
  }

  Container _buildFacilitiesTable() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 24,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.lightGrey1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          _FacilitiesItem(title: 'آسانسور', isAvalibale: promotion.hasElevator),
          _FacilitiesItem(title: 'انباری', isAvalibale: promotion.hasStorage),
          _FacilitiesItem(title: 'استخر', isAvalibale: promotion.hasPool),
          _FacilitiesItem(
            title: 'پارکینگ',
            isAvalibale: promotion.hasParking,
            haveDivider: false,
          ),
        ],
      ),
    );
  }

  HeaderComponent _buildHeader() {
    return const HeaderComponent(
      icon: AppSvg.magicpenIcon,
      title: 'امکانات',
    );
  }
}

class _FacilitiesItem extends StatelessWidget {
  const _FacilitiesItem({
    required String title,
    bool haveDivider = true,
    bool isAvalibale = false,
  })  : _haveDivider = haveDivider,
        _title = title,
        _isAvalibale = isAvalibale;
  final String _title;
  final bool _haveDivider;
  final bool _isAvalibale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            _title,
            textAlign: TextAlign.right,
            style: _isAvalibale
                ? Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: AppColor.black)
                : Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Visibility(
          visible: _haveDivider,
          child: const DottedDashedLine(
            height: 0,
            width: 300,
            dashColor: AppColor.lightGrey1,
            axis: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
