import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class AuthTextfiedComponent extends StatelessWidget {
  const AuthTextfiedComponent({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.isTextfieldForCode,
    this.textInputType,
    this.hintText,
    this.errorMessages,
    this.fieldCount = 4,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final bool isTextfieldForCode;
  final List<String>? hintText;
  final List<String?>? errorMessages;
  final int fieldCount;
  final List<TextInputType>? textInputType;
  @override
  Widget build(BuildContext context) {
    if (isTextfieldForCode) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(fieldCount, (index) {
            return SizedBox(
              width: 73,
              height: 60,
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                cursorColor: AppColor.red,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.none,
                textAlign: TextAlign.center,
                maxLength: 1,
                onChanged: (value) => _nextFieldCode(value, index),
                decoration: const InputDecoration(
                  counterText: '',
                  fillColor: AppColor.customGrey,
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
            );
          }),
        ),
      );
    } else {
      return Column(
        children: List.generate(
          fieldCount,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvizTextFiledWidget(
                  controller: controllers[index],
                  hintText: hintText![index],
                  maxLength: 25,
                  maxline: 1,
                  onchanged: (value) {},
                  onSubmitted: (value) => _nextField(value, index),
                  keyboardType: textInputType![index],
                  textinputAction: TextInputAction.done,
                  focusNode: focusNodes[index],
                  obscureText: hintText![index] == 'رمز' ||
                      hintText![index] == 'تکرار رمز',
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void _nextField(String value, int index) {
    if (value.isNotEmpty && index < 4) {
      focusNodes[index + 1].requestFocus();
    } else if (index == 3) {
      focusNodes[index].unfocus();
    }
  }

  void _nextFieldCode(String value, int index) {
    if (value.length == 1 && index < 4) {
      focusNodes[index + 1].requestFocus();
    } else if (index == 4) {
      focusNodes[index].unfocus();
    }
  }
}
