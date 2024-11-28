import 'package:aviz/Constants/color_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.imageUrl, this.raduis = 0});
  final String? imageUrl;
  final double raduis;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(raduis),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl ?? 'خطا',
        placeholder: (context, url) {
          return Container(
            color: AppColor.gery,
          );
        },
        errorWidget: (context, url, error) {
          return Image.asset('assets/images/man.png');
        },
      ),
    );
  }
}
