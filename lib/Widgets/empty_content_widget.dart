import 'package:aviz/Util/color_filtered.dart';
import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    super.key,
    required this.title,
    required this.widget,
  });
  final String title;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ColorFilteredAviz.colorFilterAt(
          scale: 3,
          widget,
        ),
        const SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Text(
            title,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}
