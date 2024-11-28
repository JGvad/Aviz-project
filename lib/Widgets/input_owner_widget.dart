import 'package:aviz/Constants/color_constant.dart';
import 'package:flutter/material.dart';

class InputOwnerComponent extends StatelessWidget {
  const InputOwnerComponent({
    super.key,
    required this.title,
    this.hintText = '',
    required this.controller,
    this.textInputType = TextInputType.number,
    this.globalKey,
    this.value,
    this.validator,
  });
  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final GlobalKey<FormFieldState>? globalKey;
  final String? value;
  final String? Function(String? value)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColor.black,
              ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 46,
          decoration: const BoxDecoration(
            color: AppColor.customGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: SizedBox(
            width: 150,
            child: TextFormField(
              key: globalKey,
              controller: controller,
              keyboardType: textInputType,
              textAlign: TextAlign.right,
              maxLength: 11,
              textInputAction: TextInputAction.done,
              cursorColor: AppColor.red,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'dana',
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(right: 5),
                border: InputBorder.none,
                counterText: "",
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColor.gery,
                      fontSize: 12,
                    ),
              ),
              validator: validator,
              initialValue: value,
            ),
          ),
        ),
      ],
    );
  }
}
