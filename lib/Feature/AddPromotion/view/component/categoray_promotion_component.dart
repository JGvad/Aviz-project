import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Feature/AddPromotion/data/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryComponent extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final List<CategoryModel> categoraies;
  const CategoryComponent({
    super.key,
    this.onNext,
    this.onPrevious,
    required this.categoraies,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categoraies.length,
      itemBuilder: (context, index) {
        return CategorayItem(
          title: categoraies[index].name,
          onNext: onNext,
        );
      },
    );
  }
}

class CategorayItem extends StatelessWidget {
  const CategorayItem({
    super.key,
    required this.title,
    required this.onNext,
  });

  final String title;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: AppColor.lightGrey1,
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
        ),
        trailing: SvgPicture.asset(
          AppSvg.redArrowLeftIcon,
        ),
        onTap: onNext,
      ),
    );
  }
}
