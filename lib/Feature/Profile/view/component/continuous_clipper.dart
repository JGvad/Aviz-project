import 'package:flutter/material.dart';

class ContinuousClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return const ContinuousRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(40),
      ),
    ).getOuterPath(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
