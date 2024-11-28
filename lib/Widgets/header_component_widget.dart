import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({super.key, required this.icon, required this.title});
  final String? icon;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon!),
        const SizedBox(width: 8),
        Text(
          title!,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}
