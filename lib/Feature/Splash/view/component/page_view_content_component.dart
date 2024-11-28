import 'package:flutter/material.dart';

class PageViewContentComponent extends StatelessWidget {
  const PageViewContentComponent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(
            right: 40,
            left: 40,
            top: 54,
            bottom: 34,
          ),
          child: Image.asset(image),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            right: 35,
            left: 35,
          ),
          child: Center(
            child: Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(height: 1.8),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
