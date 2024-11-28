import 'package:aviz/Constants/color_constant.dart';
import 'package:flutter/material.dart';

class AvizTextFiledWidget extends StatelessWidget {
  const AvizTextFiledWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onchanged,
    required this.onSubmitted,
    required this.keyboardType,
    this.minLine,
    this.horizontalContentPadding = 10,
    this.verticalContentPadding = 4,
    this.suffixIcon,
    this.defaultFillColor = AppColor.customGrey,
    this.changeFillColor = false,
    this.textinputAction,
    this.focusNode,
    this.maxLength,
    this.prefixIcon,
    this.hintColor = AppColor.gery,
    this.hintSize = 14,
    this.globalKey,
    this.value,
    this.validator,
    this.maxline,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final Function(String value) onchanged;
  final Function(String value) onSubmitted;
  final TextInputType keyboardType;
  final double horizontalContentPadding;
  final double verticalContentPadding;
  final int? minLine;
  final int? maxline;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color defaultFillColor;
  final bool changeFillColor;
  final TextInputAction? textinputAction;
  final FocusNode? focusNode;
  final int? maxLength;
  final Color? hintColor;
  final double? hintSize;
  final GlobalKey<FormFieldState>? globalKey;
  final String? value;
  final String? Function(String? value)? validator;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: globalKey,
      controller: controller,
      focusNode: focusNode,
      onChanged: onchanged,
      keyboardType: keyboardType,
      textAlign: TextAlign.right,
      onFieldSubmitted: onSubmitted,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: 'dana',
      ),
      obscureText: obscureText,
      maxLines: maxline,
      minLines: minLine,
      maxLength: maxLength,
      textInputAction: textinputAction,
      cursorColor: AppColor.red,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalContentPadding,
          vertical: verticalContentPadding,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: hintColor,
              fontSize: hintSize,
            ),
        fillColor: defaultFillColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: (defaultFillColor == Colors.white)
              ? const BorderSide(color: AppColor.lightGrey1)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: (defaultFillColor == Colors.white)
              ? const BorderSide(color: AppColor.lightGrey1)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: (defaultFillColor == Colors.white)
              ? const BorderSide(color: AppColor.lightGrey)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      validator: validator,
      initialValue: value,
    );
  }
}
