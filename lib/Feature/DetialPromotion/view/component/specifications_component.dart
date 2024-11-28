import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Feature/DetialPromotion/view/component/communication_component.dart';
import 'package:aviz/Widgets/header_component_widget.dart';
import 'package:aviz/Widgets/map_view_widget.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';

class SpecificationsComponent extends StatelessWidget {
  const SpecificationsComponent({super.key, required this.promotion});
  final PromotionModel promotion;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSpecificationTable(context),
        _buildLocationHeader(),
        _buildMapSection(),
        CommunicationComponent(promotion: promotion)
      ],
    );
  }

  MapViewWidget _buildMapSection() {
    return MapViewWidget(
      title: promotion.location,
    );
  }

  Padding _buildLocationHeader() {
    return const Padding(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 24,
      ),
      child: HeaderComponent(
        icon: AppSvg.mapIcon,
        title: 'موقعیت مکانی',
      ),
    );
  }

  Container _buildSpecificationTable(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 24,
      ),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      height: 98,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColor.lightGrey1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TableItem(
            title: 'متراژ',
            value: promotion.meterage,
          ),
          _buildDashedLine(),
          _TableItem(
            title: 'تعداد اتاق',
            value: promotion.roomCount,
          ),
          _buildDashedLine(),
          _TableItem(
            title: 'طبقه',
            value: promotion.floor,
          ),
          _buildDashedLine(),
          _TableItem(
            title: 'سال ساخت',
            value: promotion.yearBuilt,
          ),
        ],
      ),
    );
  }

  DottedDashedLine _buildDashedLine() {
    return const DottedDashedLine(
      height: 80,
      width: 0,
      dashColor: AppColor.lightGrey1,
      axis: Axis.vertical,
    );
  }
}

class _TableItem extends StatelessWidget {
  const _TableItem({required String title, required String value})
      : _title = title,
        _value = value;
  final String _title;
  final String _value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          _value,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: AppColor.black),
        ),
      ],
    );
  }
}
