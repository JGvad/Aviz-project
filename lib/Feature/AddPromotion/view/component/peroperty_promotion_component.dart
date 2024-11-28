import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Feature/AddPromotion/data/model/sub_category_model.dart';
import 'package:aviz/Feature/AddPromotion/data/model/temporary_promotion_model.dart';
import 'package:aviz/Util/result_massage.dart';
import 'package:aviz/Widgets/buttom_swicher_widget.dart';
import 'package:aviz/Widgets/header_component_widget.dart';
import 'package:aviz/Widgets/buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:aviz/Constants/color_constant.dart';
import 'package:flutter_svg/svg.dart';

class PropertyPromotionComponent extends StatefulWidget {
  const PropertyPromotionComponent(
      {super.key,
      required this.onNext,
      required this.subCateName,
      required this.subCateId,
      required this.subCategotyList});
  final VoidCallback onNext;
  final ValueNotifier<String> subCateName;
  final ValueNotifier<String> subCateId;
  final List<SubCategoryModel> subCategotyList;

  @override
  PropertyPromotionComponentState createState() =>
      PropertyPromotionComponentState();
}

class PropertyPromotionComponentState
    extends State<PropertyPromotionComponent> {
  final _switchStates = {
    'انباری': ValueNotifier(false),
    'آسانسور': ValueNotifier(false),
    'پارکینگ': ValueNotifier(false),
    'استخر': ValueNotifier(false),
  };
  final _currentMeter = ValueNotifier<String>('تعیین');
  final _currentRoom = ValueNotifier<String>('انتخاب');
  final _currentFloor = ValueNotifier<String>('انتخاب');
  final _currentYearOfBuild = ValueNotifier<String>('انتخاب');
  final _subCateId = ValueNotifier<String>('');
  final GlobalKey<FormFieldState> _areaKey = GlobalKey<FormFieldState>();
  late TextEditingController areaController;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    areaController = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const HeaderComponent(
              icon: AppSvg.categorayIcon,
              title: 'انتخاب دسته بندی آویز',
            ),
            const SizedBox(height: 32),
            _buildCategorySelection(),
            const SizedBox(height: 64),
            const HeaderComponent(icon: AppSvg.propertyIcon, title: 'مشخصات'),
            const SizedBox(height: 32),
            _buildPropertyDetails(),
            const SizedBox(height: 64),
            const HeaderComponent(icon: AppSvg.magicpenIcon, title: 'امکانات'),
            const SizedBox(height: 15),
            _buildSwitches(),
            _buildNextStepButtom(),
          ],
        ),
      ),
    );
  }

  Widget _buildNextStepButtom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ButtomWidget(
        title: 'بعدی',
        width: 343,
        onNext: () {
          if (_areaKey.currentState!.validate() &&
              _currentMeter.value != 'تعیین' &&
              _currentFloor.value != 'انتخاب' &&
              _currentRoom.value != 'انتخاب' &&
              _currentYearOfBuild.value != 'انتخاب') {
            widget.onNext();
            TemporaryPromotionModel.instance.location = areaController.text;
            TemporaryPromotionModel.instance.meterage = _currentMeter.value;
            TemporaryPromotionModel.instance.roomCount = _currentRoom.value;
            TemporaryPromotionModel.instance.floor = _currentFloor.value;
            TemporaryPromotionModel.instance.yearBuilt =
                _currentYearOfBuild.value;
            TemporaryPromotionModel.instance.subCategoryId =
                widget.subCateId.value;
            TemporaryPromotionModel.instance.hasStorage =
                _switchStates['انباری']?.value;
            TemporaryPromotionModel.instance.hasElevator =
                _switchStates['آسانسور']?.value;
            TemporaryPromotionModel.instance.hasParking =
                _switchStates['پارکینگ']?.value;
            TemporaryPromotionModel.instance.hasPool =
                _switchStates['استخر']?.value;
          } else {
            ResultMassanger.customSnackBar(
              message: 'لطفا تمام موارد خواسته شده را مشخص کنید',
              context: context,
              color: AppColor.red,
            );
          }
        },
      ),
    );
  }

  Widget _buildCategorySelection() {
    List<String> nameSubCateString =
        widget.subCategotyList.map((element) => element.name).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDropdown(
          title: 'دسته بندی',
          notifier: widget.subCateName,
          items: nameSubCateString,
        ),
        _buildPromotionArea(),
      ],
    );
  }

  Column _buildPromotionArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'محدود ملک',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: 150,
          height: 46,
          decoration: const BoxDecoration(
            color: AppColor.customGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: TextFormField(
            key: _areaKey,
            focusNode: focusNode,
            controller: areaController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.right,
            maxLength: 10,
            textInputAction: TextInputAction.done,
            cursorColor: AppColor.red,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'dana',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
              hintText: 'مثلا الهیه',
              hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColor.gery,
                    fontSize: 12,
                  ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'محدوده را مشخص کنید';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyDetails() {
    return Column(
      children: [
        Row(
          children: [
            _buildPropertyItem('متراژ', _currentMeter, 'تعیین متراژ', 50, 350),
            _buildPropertyItem(
                'تعداد اتاق', _currentRoom, 'انتخاب تعداد اتاق', 1, 10),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildPropertyItem('طبقه', _currentFloor, 'انتخاب طبقه', 1, 20),
            _buildPropertyItem(
                'سال ساخت', _currentYearOfBuild, 'انتخاب سال ساخت', 1390, 30),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitches() {
    return Column(
      children: _switchStates.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 13.5),
          child: ButtomSwicherWidget.buttomSwitcher(
            isTrue: entry.value,
            title: entry.key,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDropdown({
    required String title,
    required ValueNotifier<String> notifier,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        Transform.scale(
          scale: .95,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 1, color: AppColor.lightGrey1),
            ),
            child: ValueListenableBuilder<String>(
              valueListenable: notifier,
              builder: (context, valueDrop, child) {
                return DropdownButton<String>(
                  value: valueDrop,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: AppColor.black),
                  dropdownColor: AppColor.customGrey,
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: AppColor.black),
                  underline: Container(color: Colors.transparent),
                  items: items
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    notifier.value = newValue!;
                    _subCateId.value = newValue;
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyItem(
    String title,
    ValueNotifier<String> notifier,
    String sheetTitle,
    int increment,
    int itemCount,
  ) {
    return Expanded(
      child: _PeropertyPromotionItem(
        title: title,
        finalValue: notifier,
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return _ContentBottomSheet(
                title: sheetTitle,
                fieldValue: notifier,
                incressValues: increment,
                itemCount: itemCount,
              );
            },
          );
        },
      ),
    );
  }
}

class _ContentBottomSheet extends StatelessWidget {
  const _ContentBottomSheet({
    required this.fieldValue,
    required this.incressValues,
    required this.itemCount,
    required this.title,
  });

  final ValueNotifier<String> fieldValue;
  final int incressValues;
  final int itemCount;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () {
                    fieldValue.value = (index + incressValues).toString();
                    Navigator.pop(context);
                  },
                  child: Text(
                    '${index + incressValues}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PeropertyPromotionItem extends StatelessWidget {
  const _PeropertyPromotionItem({
    required this.finalValue,
    required this.title,
    required this.onTap,
  });

  final String title;
  final ValueNotifier<String> finalValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            width: 150,
            height: 46,
            decoration: const BoxDecoration(
              color: AppColor.customGrey,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: ValueListenableBuilder<String>(
              valueListenable: finalValue,
              builder: (context, value, child) {
                return Row(
                  children: [
                    Text(
                      value,
                      style: value == 'انتخاب' || value == 'تعیین'
                          ? Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: AppColor.lightGrey)
                          : Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: AppColor.black),
                    ),
                    const Spacer(),
                    SvgPicture.asset(AppSvg.scrollIcon),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
