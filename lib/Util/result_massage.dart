import 'package:aviz/Constants/color_constant.dart';
import 'package:flutter/material.dart';

class ResultMassanger {
  static void customSnackBar(
      {required String message,
      Color color = AppColor.black,
      required BuildContext context,
      int duration = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        content: Text(
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          message,
          style: const TextStyle(
              fontFamily: 'SM', fontSize: 14, color: AppColor.white),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
      ),
    );
  }
}
