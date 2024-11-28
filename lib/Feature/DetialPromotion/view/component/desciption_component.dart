import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Feature/DetialPromotion/view/component/communication_component.dart';
import 'package:flutter/material.dart';

class DesciptionComponent extends StatelessWidget {
  const DesciptionComponent({super.key, required this.promotion});
  final PromotionModel promotion;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            promotion.description,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.right,
          ),
        ),
        CommunicationComponent(promotion: promotion)
      ],
    );
  }
}
