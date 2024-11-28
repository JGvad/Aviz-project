import 'dart:async';
import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Feature/Authentication/bloc/bloc/auth_bloc.dart';
import 'package:aviz/Feature/Authentication/view/component/auth_textfied_component.dart';
import 'package:aviz/Feature/Dashboard/view/dashboard_screen.dart';
import 'package:aviz/Util/result_massage.dart';
import 'package:aviz/Widgets/animation_loading.dart';
import 'package:aviz/Widgets/buttom_widget.dart';
import 'package:aviz/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthConfirmCodeScreen extends StatefulWidget {
  const AuthConfirmCodeScreen({
    super.key,
    required this.title,
    required this.description,
    required this.actionName,
    required this.enterList,
  });
  final String title;
  final String description;
  final String actionName;
  final List<String> enterList;
  @override
  State<AuthConfirmCodeScreen> createState() => _AuthConfirmCodeScreenState();
}

class _AuthConfirmCodeScreenState extends State<AuthConfirmCodeScreen> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  final ValueNotifier<int> _remainingTime = ValueNotifier(120);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(4, (index) => TextEditingController(text: '1'));
    _focusNodes = List.generate(4, (index) => FocusNode());
    timerReverce(_remainingTime.value);
    const Duration(seconds: 4);
    _authRequest();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColor.white,
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthResponse) {
                state.result.fold(
                  (exception) {
                    ResultMassanger.customSnackBar(
                      message: exception,
                      context: context,
                      color: AppColor.red,
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AvizeApp(
                            isFistTime: false,
                            isLogin: false,
                          ),
                        ),
                      );
                    });
                  },
                  (result) {
                    ResultMassanger.customSnackBar(
                      message: result,
                      context: context,
                      color: AppColor.green,
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 56),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildHeader(context),
                        _buildSubHeader(context),
                        _buildAuthCodeFields(),
                        const SizedBox(height: 32),
                        _buildAuthTimerField(),
                      ],
                    ),
                  ),
                  _buildChangeScreenButtom(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AuthTextfiedComponent _buildAuthCodeFields() {
    return AuthTextfiedComponent(
      controllers: _controllers,
      focusNodes: _focusNodes,
      isTextfieldForCode: true,
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
          widget.description,
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
          widget.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }

  Widget _buildChangeScreenButtom(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoding) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: const Size(double.infinity, 52),
                  backgroundColor: AppColor.red),
              onPressed: () {},
              child: Center(
                child: AnimationLoding.threeBounce(
                  size: 20,
                  color: AppColor.white,
                ),
              ),
            ),
          );
        } else if (state is AuthResponse) {
          state.result.fold((exception) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ButtomWidget(
                title: 'دوباره تلاش کنید',
                width: 343,
                onNext: () {
                  Navigator.pop(context);
                },
              ),
            );
          }, (ok) {});
        } else {
          return Container();
        }
        return Container();
        // else {
        //   return Padding(
        //     padding: const EdgeInsets.only(bottom: 16),
        //     child: ButtomWidget(
        //       title: widget.actionName,
        //       width: 343,
        //       onNext: () {},
        //     ),
        //   );
        // }
      },
    );
  }

  _buildAuthTimerField() {
    switch (_remainingTime.value) {
      case > 0:
        return RichText(
          text: TextSpan(
            text: 'ارسال مجدد کد',
            children: [
              TextSpan(
                text: ' ${formatTime(_remainingTime.value)} ',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 14,
                    ),
              ),
            ],
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 14,
                  color: AppColor.textGery,
                ),
          ),
        );

      case <= 0:
        return TextButton(
          onPressed: () {
            _timer!.cancel();
            _remainingTime.value = 30;
            timerReverce(_remainingTime.value);
          },
          child: RichText(
            text: TextSpan(
              text: 'ارسال مجدد کد',
              children: [
                TextSpan(
                  text: ' 00:00',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 14,
                        color: AppColor.textGery,
                      ),
                ),
              ],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 14),
            ),
          ),
        );
    }
  }

  void timerReverce(int remainingTime) {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          if (remainingTime > 0) {
            _remainingTime.value--;
          } else {
            _timer!.cancel();
          }
        });
      },
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return minutes.toString().padLeft(2, '0') +
        ":" +
        secs.toString().padLeft(2, '0');
  }

  void _authRequest() {
    if (widget.enterList.length == 2) {
      context.read<AuthBloc>().add(
            AuthLoginUser(
              username: widget.enterList[0],
              password: widget.enterList[1],
            ),
          );
    } else {
      context.read<AuthBloc>().add(
            AuthRegiserUser(
              username: widget.enterList[0],
              name: widget.enterList[1],
              phone: widget.enterList[2],
              password: widget.enterList[3],
              passwordConfirm: widget.enterList[4],
            ),
          );
    }
  }

  @override
  void dispose() {
    for (var controler in _controllers) {
      controler.dispose();
    }
    for (var controler in _controllers) {
      controler.dispose();
    }
    super.dispose();
  }
}
