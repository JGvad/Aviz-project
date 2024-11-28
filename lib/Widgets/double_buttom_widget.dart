import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Widgets/buttom_widget.dart';
import 'package:flutter/material.dart';

class DoubleBottomWidget extends StatelessWidget {
  const DoubleBottomWidget({
    super.key,
    required this.firstTitle,
    required this.secendTitle,
    this.isFirstAvalible = true,
    this.isSecondAvalible = true,
    this.width = 159,
    this.color = AppColor.red,
    this.firstIcon,
    this.secendIcon,
    this.toLeft,
    this.onTapFirst,
    this.onTapSecend,
  });
  final String firstTitle;
  final String secendTitle;
  final double? width;
  final Color? color;
  final String? firstIcon;
  final String? secendIcon;
  final bool? toLeft;
  final VoidCallback? onTapFirst;
  final VoidCallback? onTapSecend;
  final bool isFirstAvalible;
  final bool isSecondAvalible;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isFirstAvalible == false) ...{
            Visibility(
              visible: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ButtomWidget(
                  title: firstTitle,
                  width: width!,
                  toLeft: toLeft,
                  icon: firstIcon,
                  onNext: onTapFirst,
                ),
              ),
            ),
            Flexible(
              child: Text(
                'امکان چت داده نشده; تماس بگیرید',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          } else ...{
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ButtomWidget(
                  title: firstTitle,
                  width: width!,
                  toLeft: toLeft,
                  icon: firstIcon,
                  onNext: onTapFirst,
                ),
              ),
            ),
          },
          if (isSecondAvalible == false) ...{
            Visibility(
              visible: false,
              child: ButtomWidget(
                title: secendTitle,
                toLeft: toLeft,
                width: width!,
                icon: secendIcon,
                onNext: onTapSecend,
              ),
            ),
            Flexible(
              child: Text(
                'شماره تماس مخفی شده است; پیام دهید',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          } else ...{
            Visibility(
              visible: true,
              child: ButtomWidget(
                title: secendTitle,
                toLeft: toLeft,
                width: width!,
                icon: secendIcon,
                onNext: onTapSecend,
              ),
            )
          }
        ],
      ),
    );
  }
}
