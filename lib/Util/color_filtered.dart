import 'package:aviz/Constants/color_constant.dart';
import 'package:flutter/material.dart';

class ColorFilteredAviz {
  static Widget colorFilterAt(Widget widget, {double scale = 1}) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        AppColor.red,
        BlendMode.srcIn,
      ),
      child: Transform.scale(scale: scale, child: widget),
    );
  }
}
