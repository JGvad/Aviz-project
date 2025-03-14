import 'dart:io';

import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Feature/AddPromotion/bloc/bloc/add_promotion_bloc.dart';
import 'package:aviz/Feature/AddPromotion/data/model/temporary_promotion_model.dart';
import 'package:aviz/Feature/Dashboard/view/dashboard_screen.dart';
import 'package:aviz/Feature/Home/bloc/bloc/home_bloc.dart';
import 'package:aviz/Util/result_massage.dart';
import 'package:aviz/UtilNetwork/auth_management.dart';
import 'package:aviz/Widgets/animation_loading.dart';
import 'package:aviz/Widgets/buttom_swicher_widget.dart';
import 'package:aviz/Widgets/buttom_widget.dart';
import 'package:aviz/Widgets/header_component_widget.dart';
import 'package:aviz/Widgets/input_owner_widget.dart';
import 'package:aviz/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class ConfirmPromotionConponent extends StatefulWidget {
  const ConfirmPromotionConponent({super.key});

  @override
  State<ConfirmPromotionConponent> createState() =>
      _ConfirmPromotionConponentState();
}

class _ConfirmPromotionConponentState extends State<ConfirmPromotionConponent> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _phoneController;
  late TextEditingController _priceController;
  final swithcers = {
    'فعال کردن گفتگو': ValueNotifier(true),
    'فعال کردن تماس': ValueNotifier(true),
  };
  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  final GlobalKey<FormFieldState> _titleKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _descriptionKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phoneKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _priceKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _phoneController = TextEditingController();
    _priceController = TextEditingController();
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocListener<AddPromotionBloc, AddPromotionState>(
            listener: (context, state) {
              if (state is AddPromotionResponse) {
                state.response.fold(
                  (exception) {
                    return ResultMassanger.customSnackBar(
                      context: context,
                      message: exception,
                      color: AppColor.red,
                    );
                  },
                  (response) {
                    return ResultMassanger.customSnackBar(
                      message: response,
                      context: context,
                    );
                  },
                );
                BlocProvider.of<HomeBloc>(context).add(HomeFetchData());
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            },
            child: Column(
              children: [
                const HeaderComponent(
                  icon: AppSvg.cameraIcon,
                  title: 'تصویر آویز',
                ),
                const _PickerPictureComponent(),
                const HeaderComponent(
                  icon: AppSvg.titleIcon,
                  title: 'عنوان آویز',
                ),
                _buildTitleField(),
                const HeaderComponent(
                  icon: AppSvg.explainIcon,
                  title: ' توضیحات',
                ),
                _buildDescription(),
                const SizedBox(height: 18),
                _buildOwnerProperty(),
                const SizedBox(height: 25),
                _buildSwitcherButtom(),
                _buildNextStepButtom(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildOwnerProperty() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InputOwnerComponent(
          title: 'شماره تماس',
          hintText: 'مثلا : 0993150849',
          controller: _phoneController,
          textInputType: TextInputType.phone,
          globalKey: _phoneKey,
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !RegExp(r'^\d{11}$').hasMatch(value)) {
              return 'شماره موبایل معتبر نیست';
            }
            return null;
          },
        ),
        InputOwnerComponent(
          title: ' قیمت ملک (تومان)',
          controller: _priceController,
          textInputType: TextInputType.number,
          globalKey: _priceKey,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'قیمت آگهی را مشخص کنید';
            } else if (value.length < 7) {
              return 'قیمت منطقی نیست';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildNextStepButtom() {
    return BlocBuilder<AddPromotionBloc, AddPromotionState>(
      builder: (context, state) {
        if (state is AddPromotionLoding) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: AnimationLoding.threeBounce(
                    size: 20,
                    color: AppColor.white,
                  ),
                ),
              ));
        } else {
          return Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 32,
            ),
            child: ButtomWidget(
              width: double.infinity,
              title: 'ثبت آگهی',
              onNext: () async {
                if (_titleKey.currentState!.validate() &&
                    _descriptionKey.currentState!.validate() &&
                    _phoneKey.currentState!.validate() &&
                    _priceKey.currentState!.validate() &&
                    TemporaryPromotionModel.instance.thumbnailUrl != null) {
                  String? userId = await AuthManagement.readUserId();

                  TemporaryPromotionModel.instance.title =
                      _titleController.text;
                  TemporaryPromotionModel.instance.description =
                      _descriptionController.text;
                  TemporaryPromotionModel.instance.phoneNumber =
                      _phoneController.text;
                  TemporaryPromotionModel.instance.price =
                      _priceController.text;
                  TemporaryPromotionModel.instance.chatEnabled =
                      swithcers['فعال کردن گفتگو']?.value;
                  TemporaryPromotionModel.instance.callEnabled =
                      swithcers['فعال کردن تماس']?.value;
                  if (!context.mounted) {
                    return;
                  } else {
                    BlocProvider.of<AddPromotionBloc>(context).add(
                      AddPromotionRequest(
                        title: TemporaryPromotionModel.instance.title!,
                        description:
                            TemporaryPromotionModel.instance.description!,
                        thumbnail:
                            TemporaryPromotionModel.instance.thumbnailUrl!,
                        price: TemporaryPromotionModel.instance.price!,
                        meterage: TemporaryPromotionModel.instance.meterage!,
                        roomCount: TemporaryPromotionModel.instance.roomCount!,
                        floor: TemporaryPromotionModel.instance.floor!,
                        yearBuilt: TemporaryPromotionModel.instance.yearBuilt!,
                        location: TemporaryPromotionModel.instance.location!,
                        subCategoryId:
                            TemporaryPromotionModel.instance.subCategoryId!,
                        phoneNumber:
                            TemporaryPromotionModel.instance.phoneNumber!,
                        hasElevator:
                            TemporaryPromotionModel.instance.hasElevator!,
                        hasParking:
                            TemporaryPromotionModel.instance.hasParking!,
                        hasStorage:
                            TemporaryPromotionModel.instance.hasStorage!,
                        showExactLocation:
                            TemporaryPromotionModel.instance.showExactLocation!,
                        chatEnabled:
                            TemporaryPromotionModel.instance.chatEnabled!,
                        callEnabled:
                            TemporaryPromotionModel.instance.callEnabled!,
                        isHot: true,
                        hasPool: TemporaryPromotionModel.instance.hasPool!,
                        userOwner: userId!,
                      ),
                    );
                    TemporaryPromotionModel.instance.clear();
                  }
                } else if (TemporaryPromotionModel.instance.thumbnailUrl ==
                    null) {
                  return ResultMassanger.customSnackBar(
                    message: 'عکس برای اگهی مشخص کنید',
                    context: context,
                    color: AppColor.red,
                  );
                }
              },
            ),
          );
        }
      },
    );
  }

  Column _buildSwitcherButtom() {
    return Column(
      children: swithcers.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ButtomSwicherWidget.buttomSwitcher(
            isTrue: entry.value,
            title: entry.key,
          ),
        );
      }).toList(),
    );
  }

  Padding _buildDescription() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 32,
      ),
      child: AvizTextFiledWidget(
        controller: _descriptionController,
        hintText: 'توضیحات آویز را وارد کنید ...',
        onchanged: (value) {},
        onSubmitted: (onsub) {},
        keyboardType: TextInputType.text,
        minLine: 4,
        focusNode: _descriptionFocus,
        globalKey: _descriptionKey,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'توضیحات آویز را وارد کنید';
          } else if (!RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(value)) {
            return 'توضیحات آویز باید فارسی باشد';
          }
          return null;
        },
      ),
    );
  }

  Padding _buildTitleField() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 32,
      ),
      child: AvizTextFiledWidget(
        controller: _titleController,
        hintText: 'عنوان اویز را وارد کنید',
        maxLength: 25,
        minLine: 1,
        onchanged: (value) {},
        onSubmitted: (onsub) {
          FocusScope.of(context).requestFocus(_descriptionFocus);
        },
        keyboardType: TextInputType.text,
        focusNode: _titleFocus,
        globalKey: _titleKey,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'عنوان آویز را وارد کنید';
          } else if (!RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(value)) {
            return 'عنوان آویز باید فارسی باشد';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _descriptionFocus.dispose();
    _titleFocus.dispose();

    super.dispose();
  }
}

class _PickerPictureComponent extends StatefulWidget {
  const _PickerPictureComponent();

  @override
  State<_PickerPictureComponent> createState() =>
      _PickerPictureComponentState();
}

class _PickerPictureComponentState extends State<_PickerPictureComponent> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
      );

      if (croppedFile != null) {
        setState(() {
          _image = File(croppedFile.path);
          TemporaryPromotionModel.instance.thumbnailUrl = _image;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 32),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 144,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: DashedBorder.fromBorderSide(
                dashLength: 10,
                side: BorderSide(
                  color:
                      _image != null ? Colors.transparent : AppColor.lightGrey,
                  width: 1,
                ),
              ),
            ),
            child: _image != null
                ? Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: Icon(
                      Icons.image,
                      color: AppColor.lightGrey,
                      size: 48,
                    ),
                  ),
          ),
          Positioned(
            top: 25,
            child: _image != null
                ? const SizedBox.shrink()
                : Text(
                    'لطفا تصویر آویز خود را بارگذاری کنید',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
          ),
          _image != null
              ? Positioned(
                  left: 5,
                  top: 5,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: IconButton(
                      onPressed: _getImage,
                      icon: const Icon(
                        size: 30,
                        Icons.change_circle_sharp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              : Positioned(
                  right: 80,
                  left: 80,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: ButtomWidget(
                      title: 'انتخاب تصویر',
                      icon: AppSvg.uploadIcon,
                      fontSize: 14,
                      toLeft: false,
                      onNext: _getImage,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
