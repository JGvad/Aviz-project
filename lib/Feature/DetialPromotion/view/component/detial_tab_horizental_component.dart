import 'package:aviz/Constants/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetialTabHorizentalComponent extends StatelessWidget {
  const DetialTabHorizentalComponent({
    super.key,
    required ValueNotifier<int> selectedSegment,
  }) : _selectedSegment = selectedSegment;

  final ValueNotifier<int> _selectedSegment;

  @override
  Widget build(BuildContext context) {
    final options = ['مشخصات', 'قیمت', 'امکانات', 'توضیحات'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(options.length, (index) {
        return Expanded(
          child: _buildSegmentButton(
            context,
            title: options[index],
            index: index,
          ),
        );
      }),
    );
  }

  Widget _buildSegmentButton(BuildContext context,
      {required String title, required int index}) {
    final bool isSelected = _selectedSegment.value == index;
    final Color color = isSelected ? AppColor.red : AppColor.white;
    final Color textColor = isSelected ? AppColor.white : AppColor.red;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.customGrey),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: CupertinoButton(
        minSize: 30,
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: color,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: textColor, fontSize: 13),
        ),
        onPressed: () {
          _selectedSegment.value = index;
        },
      ),
    );
  }
}
