import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Di/di.dart';
import 'package:aviz/Feature/Authentication/bloc/bloc/auth_bloc.dart';
import 'package:aviz/Feature/Authentication/view/auth_confirm_screen.dart';
import 'package:aviz/Feature/Authentication/view/auth_register_screen.dart';
import 'package:aviz/Feature/Authentication/view/component/auth_link_buttom_component.dart';
import 'package:aviz/Feature/Authentication/view/component/auth_textfied_component.dart';
import 'package:aviz/Util/result_massage.dart';
import 'package:aviz/Widgets/buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthLoginScreen extends StatefulWidget {
  const AuthLoginScreen({super.key});

  @override
  State<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends State<AuthLoginScreen> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  final List<String> _hintList = [
    'نام کاربری',
    'رمز',
  ];
  final List<TextInputType> _textInputTypes = [
    TextInputType.name,
    TextInputType.text,
  ];
  @override
  void initState() {
    super.initState();
    _controllers = List.generate(2, (index) => TextEditingController());
    _focusNodes = List.generate(2, (index) => FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColor.white,
          body: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildHeader(context),
                      _buildSubHeader(context),
                      _buildInforamtionField(),
                    ],
                  ),
                ),
                _buildNextStepButtom(),
                _buildChangeScreenButtom(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  AuthLinkButtomComponent _buildChangeScreenButtom(BuildContext context) {
    return AuthLinkButtomComponent(
      title: 'تاحالا ثبت نام نکردی؟ ',
      action: 'ثبت نام',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthRegisterScreen(),
        ),
      ),
    );
  }

  Padding _buildNextStepButtom() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ButtomWidget(
        title: 'مرحله بعدی',
        width: 343,
        onNext: () {
          for (int i = 0; i < _controllers.length; i++) {
            String? validationMessage = validateField(
              value: _controllers[i].text,
              fieldName: _hintList[i],
            );
            if (validationMessage != null) {
              ResultMassanger.customSnackBar(
                message: validationMessage,
                context: context,
              );
              return;
            }
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => locator.get<AuthBloc>(),
                child: AuthConfirmCodeScreen(
                  enterList: [
                    _controllers[0].text,
                    _controllers[1].text,
                  ],
                  title: 'تایید شماره موبایل',
                  description: 'کد ورود پیامک شده را وارد کنید',
                  actionName: 'ورود',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AuthTextfiedComponent _buildInforamtionField() {
    return AuthTextfiedComponent(
      controllers: _controllers,
      focusNodes: _focusNodes,
      hintText: _hintList,
      textInputType: _textInputTypes,
      isTextfieldForCode: false,
      fieldCount: 2,
    );
  }

  Padding _buildSubHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 32,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          'خوشحالیم که مجددا آویز رو برای آگهی انتخاب کردی!',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          'ورود به ',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SvgPicture.asset(AppSvg.logotype)
      ],
    );
  }

  String? validateField({required String value, required String fieldName}) {
    if (value.isEmpty) {
      return 'لطفاً $fieldName را وارد کنید';
    }
    if (fieldName == 'شماره موبایل' && !RegExp(r'^\d{11}$').hasMatch(value)) {
      return 'شماره موبایل وارد شده معتبر نیست';
    }
    if (fieldName == 'رمز' && value.length < 8) {
      return 'رمز باید حداقل ۸ کاراکتر باشد';
    }
    return null;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
