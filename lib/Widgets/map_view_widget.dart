import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Widgets/buttom_widget.dart';
import 'package:flutter/material.dart';

class MapViewWidget extends StatelessWidget {
  const MapViewWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 144,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Image.asset(
            'assets/images/map_image.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 75,
          left: 75,
          child: ButtomWidget(
            width: 185,
            title: title,
            icon: AppSvg.locationIcon,
            onNext: () {},
          ),
        )
      ],
    );
  }
}
