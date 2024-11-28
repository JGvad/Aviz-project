import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Core/data/models/promotion_hive_model.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Util/extension/int_extensions.dart';
import 'package:aviz/Widgets/cheched_image_widget.dart';
import 'package:flutter/material.dart';

class LastestPromotionCard extends StatelessWidget {
  final PromotionModel? promotion;
  final SavedPromotion? savedPromotion;
  final bool isSavedPromotion;

  const LastestPromotionCard({
    super.key,
    this.promotion,
    this.savedPromotion,
    this.isSavedPromotion = false,
  });

  @override
  Widget build(BuildContext context) {
    final String title =
        isSavedPromotion ? savedPromotion!.title : promotion!.title;
    final String description =
        isSavedPromotion ? savedPromotion!.description : promotion!.description;
    final String imageUrl = isSavedPromotion
        ? savedPromotion!.thumbnailUrl
        : promotion!.thumbnailUrl;
    final String price = isSavedPromotion
        ? savedPromotion!.price.numberSeprated()
        : promotion!.price.numberSeprated();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 148,
      padding: const EdgeInsets.all(16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child: CachedImage(
              imageUrl: imageUrl,
              raduis: 4,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: Text(
                    title,
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  child: Text(
                    description,
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
                          price,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
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
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.black,
                              ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
