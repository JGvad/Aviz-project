import 'package:aviz/Constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtomWidget extends StatelessWidget {
  const ButtomWidget(
      {required this.title,
      super.key,
      this.icon,
      this.width = 159,
      this.color = AppColor.red,
      this.onNext,
      this.fontSize,
      this.toLeft = true,
      this.hight = 40});
  final String title;
  final double width;
  final double hight;
  final Color? color;
  final VoidCallback? onNext;
  final String? icon;
  final double? fontSize;
  final bool? toLeft;
  @override
  Widget build(BuildContext context) {
    return icon != null
        ? Stack(
            children: [
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: AppColor.red,
                    ),
                  ),
                  backgroundColor: title == 'ورود' ? AppColor.white : color,
                  minimumSize: Size(width, hight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: title == 'ورود'
                                  ? AppColor.red
                                  : AppColor.white,
                              fontSize: fontSize,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              toLeft == true
                  ? Positioned(
                      top: 12,
                      left: 8,
                      child: SvgPicture.asset(
                        icon!,
                        width: 25,
                        height: 25,
                      ),
                    )
                  : Positioned(
                      top: 12,
                      right: 8,
                      child: SvgPicture.asset(
                        icon!,
                        width: 25,
                        height: 25,
                      ),
                    ),
            ],
          )
        : GestureDetector(
            onTap: onNext,
            child: Container(
              width: width,
              height: hight,
              decoration: BoxDecoration(
                color: title == 'ورود' ? AppColor.white : color,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.red),
              ),
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: fontSize,
                        color: title == 'ورود' ? AppColor.red : AppColor.white,
                      ),
                ),
              ),
            ),
          );
  }
}
