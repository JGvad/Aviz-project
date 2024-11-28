import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Di/di.dart';
import 'package:aviz/Feature/Authentication/bloc/bloc/auth_bloc.dart';
import 'package:aviz/Feature/Authentication/view/auth_confirm_screen.dart';
import 'package:aviz/Feature/Authentication/view/auth_login_screen.dart';
import 'package:aviz/Feature/Authentication/view/component/auth_link_buttom_component.dart';
import 'package:aviz/Feature/Authentication/view/component/auth_textfied_component.dart';
import 'package:aviz/Util/result_massage.dart';
import 'package:aviz/Widgets/buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AuthRegisterScreen extends StatefulWidget {
  const AuthRegisterScreen({super.key});

  @override
  State<AuthRegisterScreen> createState() => _AuthRegisterScreenState();
}

class _AuthRegisterScreenState extends State<AuthRegisterScreen> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  // لیست ثابت برای فیلدها
  static const List<String> hintList = [
    'نام کاربری',
    'نام و نام خانوادگی',
    'شماره موبایل',
    'رمز',
    'تکرار رمز',
  ];

  final List<TextInputType> textInputTypes = [
    TextInputType.name,
    TextInputType.name,
    TextInputType.phone,
    TextInputType.text,
    TextInputType.text,
  ];

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(hintList.length, (index) => TextEditingController());
    _focusNodes = List.generate(hintList.length, (index) => FocusNode());
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
                      _buildInformationField()
                    ],
                  ),
                ),
                _buildNextStepButtom(context),
                _buildChangeScreenButtom(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  AuthTextfiedComponent _buildInformationField() {
    return AuthTextfiedComponent(
      controllers: _controllers,
      focusNodes: _focusNodes,
      isTextfieldForCode: false,
      fieldCount: hintList.length,
      hintText: hintList,
      textInputType: textInputTypes,
    );
  }

  AuthLinkButtomComponent _buildChangeScreenButtom(BuildContext context) {
    return AuthLinkButtomComponent(
      title: 'تاحالا ثبت نام کردی؟',
      action: ' ورود',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthLoginScreen(),
        ),
      ),
    );
  }

  Padding _buildNextStepButtom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ButtomWidget(
        title: 'مرحله بعدی',
        width: 343,
        onNext: () {
          for (int i = 0; i < _controllers.length; i++) {
            String? validationMessage = validateField(
              value: _controllers[i].text,
              fieldName: hintList[i],
            );
            if (validationMessage != null) {
              ResultMassanger.customSnackBar(
                message: validationMessage,
                context: context,
              );
              return;
            }
          }
          if (_controllers[3].text != _controllers[4].text) {
            ResultMassanger.customSnackBar(
              message: 'مقادیر رمزها یکسان نیستند',
              context: context,
            );
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => locator.get<AuthBloc>(),
                child: AuthConfirmCodeScreen(
                  enterList: _controllers.map((c) => c.text).toList(),
                  title: 'تایید شماره موبایل',
                  description: 'کد ورود پیامک شده را وارد کنید',
                  actionName: 'ثبت نام',
                ),
              ),
            ),
          );
        },
      ),
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
          'این فوق العادست که آویزو برای آگهی هات انتخاب کردی!',
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
          'خوش اومدی به ',
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

    if (fieldName == hintList[0] && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'نام کاربری باید به لاتین باشد';
    }

    if (fieldName == hintList[1] &&
        !RegExp(r'^[آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی\s]+$').hasMatch(value)) {
      return 'نام و نام خانوادگی باید فارسی باشد';
    }

    if (fieldName == hintList[2] && !RegExp(r'^\d{11}$').hasMatch(value)) {
      return 'شماره موبایل وارد شده معتبر نیست';
    }

    if (fieldName == hintList[3] && value.length < 8) {
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
