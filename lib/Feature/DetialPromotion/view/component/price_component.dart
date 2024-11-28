import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Feature/DetialPromotion/view/component/communication_component.dart';
import 'package:aviz/Util/extension/int_extensions.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';

class PriceComponent extends StatelessWidget {
  const PriceComponent({super.key, required this.promotion});
  final PromotionModel promotion;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPriceTable(),
        CommunicationComponent(promotion: promotion)
      ],
    );
  }

  Container _buildPriceTable() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      height: 96,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.lightGrey1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _PriceTableItem(
            title: 'قیمت هر متر:',
            value: promotion.pricePerMeter.numberSeprated(),
          ),
          _buildDashedLine(),
          _PriceTableItem(
            title: 'قیمت کل :',
            value: promotion.price.numberSeprated(),
          )
        ],
      ),
    );
  }

  DottedDashedLine _buildDashedLine() {
    return const DottedDashedLine(
      height: 0,
      width: 300,
      dashColor: AppColor.lightGrey1,
      axis: Axis.horizontal,
    );
  }
}

class _PriceTableItem extends StatelessWidget {
  const _PriceTableItem({required String title, required String value})
      : _title = title,
        _value = value;
  final String _title;
  final String _value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          _title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColor.black,
              ),
        ),
        const Spacer(),
        Text(
          _value,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColor.black,
              ),
        ),
      ],
    );
  }
}
