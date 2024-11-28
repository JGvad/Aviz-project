import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Util/extension/int_extensions.dart';
import 'package:aviz/Widgets/cheched_image_widget.dart';
import 'package:flutter/material.dart';

class HotPromotionCard extends StatelessWidget {
  final PromotionModel promotion;
  const HotPromotionCard({super.key, required this.promotion});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 270,
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        shadows: const [
          BoxShadow(
            color: Color.fromARGB(255, 218, 218, 218),
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(
              0.0,
              10,
            ),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Container(
            width: 192,
            height: 112,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: CachedImage(
              imageUrl: promotion.thumbnailUrl,
              raduis: 4,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            child: Text(
              promotion.title,
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 17),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            child: Text(
              promotion.description,
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 12),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 29,
                decoration: BoxDecoration(
                  color: AppColor.gayred,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    promotion.price.numberSeprated(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 12,
                          color: AppColor.red,
                        ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                ':قیمت',
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
