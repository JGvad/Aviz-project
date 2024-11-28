import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Feature/AddPromotion/data/model/temporary_promotion_model.dart';
import 'package:aviz/Widgets/buttom_swicher_widget.dart';
import 'package:aviz/Widgets/buttom_widget.dart';
import 'package:aviz/Widgets/header_component_widget.dart';
import 'package:aviz/Widgets/map_view_widget.dart';
import 'package:flutter/material.dart';

class LocationPromotionComponent extends StatefulWidget {
  const LocationPromotionComponent({super.key, required this.onNext});
  final VoidCallback onNext;
  @override
  State<LocationPromotionComponent> createState() =>
      _LocationPromotionComponentState();
}

class _LocationPromotionComponentState
    extends State<LocationPromotionComponent> {
  final _isTrue = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const HeaderComponent(icon: AppSvg.mapIcon, title: 'موقعیت مکانی'),
            _buildSubHeader(context),
            const MapViewWidget(title: 'آدرس '),
            _builPrivacyButtom(),
            const Spacer(),
            _buildNextStepButtom()
          ],
        ),
      ),
    );
  }

  Padding _buildNextStepButtom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ButtomWidget(
        title: 'بعدی',
        width: 343,
        onNext: () {
          widget.onNext();
          TemporaryPromotionModel.instance.showExactLocation = _isTrue.value;
        },
      ),
    );
  }

  Padding _builPrivacyButtom() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: ValueListenableBuilder(
        valueListenable: _isTrue,
        builder: (context, isTrue, child) {
          return ButtomSwicherWidget.buttomSwitcher(
            isTrue: _isTrue,
            title: 'موقعیت دقیق نقشه نمایش داده شود؟',
          );
        },
      ),
    );
  }

  Padding _buildSubHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 32,
      ),
      child: Text(
        'بعد انتخاب محل دقیق روی نقشه میتوانید نمایش آن را فعال یا غیر فعال کنید تا حریم خصوصی شما حفظ شود.',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
