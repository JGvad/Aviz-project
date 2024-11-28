import 'package:aviz/Constants/color_constant.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AnimationLoding {
  static Widget circle({Color color = AppColor.red}) {
    return Center(
      child: SpinKitCircle(color: color),
    );
  }

  static Widget threeBounce({Color color = AppColor.red, double size = 20}) {
    return Center(
      child: SpinKitThreeBounce(
        color: color,
        size: size,
      ),
    );
  }
}
