import 'package:aviz/Constants/color_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthLinkButtomComponent extends StatelessWidget {
  const AuthLinkButtomComponent({
    super.key,
    required String title,
    required String action,
    required VoidCallback onTap,
  })  : _title = title,
        _action = action,
        _onTap = onTap;
  final String _title;
  final String _action;
  final VoidCallback _onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        text: TextSpan(
          text: _title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: AppColor.gery),
          children: [
            TextSpan(
                text: _action,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: AppColor.red),
                recognizer: TapGestureRecognizer()..onTap = _onTap),
          ],
        ),
      ),
    );
  }
}
