import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Widgets/double_buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunicationComponent extends StatelessWidget {
  const CommunicationComponent({
    super.key,
    required this.promotion,
  });

  final PromotionModel promotion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      child: DoubleBottomWidget(
        isFirstAvalible: promotion.chatEnabled,
        firstTitle: 'گفتگو',
        onTapFirst: () {
          final url = Uri(scheme: 'tel', path: promotion.phoneNumber);
          launchUrl(url);
        },
        firstIcon: AppSvg.messageIcon,
        onTapSecend: () {
          final url = Uri(scheme: 'tel', path: promotion.phoneNumber);
          launchUrl(url);
        },
        isSecondAvalible: promotion.callEnabled,
        secendTitle: ' شماره تماس',
        secendIcon: AppSvg.callIcon,
      ),
    );
  }
}
