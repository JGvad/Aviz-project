import 'package:aviz/Constants/color_constant.dart';
import 'package:flutter/material.dart';

class ButtomSwicherWidget extends StatelessWidget {
  const ButtomSwicherWidget.buttomSwitcher({
    super.key,
    required this.isTrue,
    required this.title,
  });

  final ValueNotifier<bool> isTrue;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isTrue,
      builder: (context, value, child) => Container(
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
          trailing: Transform.scale(
            scale: .65,
            child: Switch.adaptive(
              value: value,
              activeColor: AppColor.white,
              inactiveTrackColor: const Color.fromARGB(255, 93, 99, 111),
              inactiveThumbColor: AppColor.white,
              activeTrackColor: AppColor.red,
              onChanged: (newValue) {
                isTrue.value = newValue;
              },
            ),
          ),
          onTap: () {
            isTrue.value = !isTrue.value;
          },
        ),
      ),
    );
  }
}
