import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });
  final String title;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: AppColor.lightGrey1,
        ),
      ),
      child: ListTile(
        splashColor: Colors.transparent,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
        ),
        leading: SvgPicture.asset(
          icon,
        ),
        trailing: SvgPicture.asset(AppSvg.arrowLeftIcon),
        onTap: onTap,
      ),
    );
  }
}
