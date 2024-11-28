import 'dart:io';

import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Feature/AddPromotion/data/model/temporary_promotion_model.dart';
import 'package:aviz/Feature/Authentication/view/auth_login_screen.dart';
import 'package:aviz/Feature/ListPromotion/view/promotion_list_screen.dart';
import 'package:aviz/Feature/Profile/bloc/bloc/profile_bloc.dart';
import 'package:aviz/Feature/Profile/view/component/continuous_clipper.dart';
import 'package:aviz/Feature/Profile/view/component/profile_item.dart';
import 'package:aviz/UtilNetwork/auth_management.dart';
import 'package:aviz/Widgets/animation_loading.dart';
import 'package:aviz/Widgets/buttom_swicher_widget.dart';
import 'package:aviz/Widgets/buttom_widget.dart';
import 'package:aviz/Widgets/cheched_image_widget.dart';
import 'package:aviz/Widgets/header_component_widget.dart';
import 'package:aviz/Widgets/input_owner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameFieldcontroller;
  late TextEditingController _phoneFieldcontroller;
  late ProfileBloc _profileBloc;
  final _isTrue = ValueNotifier<bool>(true);
  String? userId;
  @override
  void initState() {
    super.initState();
    _nameFieldcontroller = TextEditingController();
    _phoneFieldcontroller = TextEditingController();
    _profileBloc = context.read<ProfileBloc>();
    _initializeUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: _buildAppBar(context),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoding) {
                return AnimationLoding.threeBounce(size: 25);
              } else if (state is ProfileFetchDataResponse) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        state.user.fold(
                          (exception) {
                            return Text(exception);
                          },
                          (user) {
                            return Column(
                              children: [
                                const HeaderComponent(
                                  icon: AppSvg.personIcon,
                                  title: 'حساب کاربری',
                                ),
                                _buildProfileInfo(
                                  context: context,
                                  name: user.name,
                                  phone: user.phone,
                                  isVaild: user.isValidUser,
                                  thumbnail: user.thumbnail,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 32),
                                  child: Divider(color: AppColor.lightGrey1),
                                ),
                                state.userPromotion.fold(
                                  (exception) {
                                    return Text(exception);
                                  },
                                  (userPromotion) {
                                    return ProfileItem(
                                      title: 'آگهی های من',
                                      icon: AppSvg.doubleNoteIcon,
                                      onTap: () => _changeScreenMethod(
                                        toScreen: PromotionListScreen(
                                          promotionList: userPromotion,
                                          title: 'آگهی های من',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                state.savedPromotion.fold(
                                  (exception) {
                                    return Text(exception);
                                  },
                                  (savedPromotion) {
                                    return ProfileItem(
                                      title: 'ذخیره شده ها',
                                      icon: AppSvg.doubleSaveIcon,
                                      onTap: () => _changeScreenMethod(
                                        toScreen: PromotionListScreen(
                                          title: 'ذخیره شده ها',
                                          savedPromotion: savedPromotion,
                                          isSavedPromotion: true,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        Column(
                          children: [
                            ProfileItem(
                              title: 'تنظیمات',
                              icon: AppSvg.settingIcon,
                              onTap: () => _buildContentButtomSheet(
                                context,
                                height: 150,
                                child: _buildContentOfSetting(),
                              ),
                            ),
                            ProfileItem(
                              title: 'پشتیبانی و قوانین',
                              icon: AppSvg.messageAndQuestionIcon,
                              onTap: () => _buildContentButtomSheet(
                                context,
                                height: 200,
                                child: _buildContentOfQuestion(context),
                              ),
                            ),
                            ProfileItem(
                              title: 'درباره آویز',
                              icon: AppSvg.infoAppIcon,
                              onTap: () => _buildContentButtomSheet(
                                context,
                                height: 100,
                                child: _buildAboutAviz(context),
                              ),
                            ),
                            _buildAppVersionInfo(context)
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const Text('مشکلی پیش امده');
            },
          ),
        ),
      ),
    );
  }

  Text _buildAboutAviz(BuildContext context) {
    return Text(
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      'در آویز ملک خود را برای فروش،اجاره و رهن آگهی کنید و یا اگر دنبال ملک با مشخصات دلخواه خود هستید آویز ها را ببینید',
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColor.black,
          ),
    );
  }

  Column _buildContentOfQuestion(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
            border: Border.all(
              color: AppColor.red,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Text(
                'چرا با اینکه پرداخت را انجام داده‌ام، خدمتی دریافت نکرده‌ام؟',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColor.black,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                '.لطفا توجه کنید که اینجا منظور از خدمت، موارد مربوط به ثبت و ارتقای آگهی در برنامه آویز است. به این صورت که بابت ثبت و یا ارتقای آگهی پرداخت انجام داده اید اما خدمت مورد نظر بر روی آگهی اعمال نشده است.',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'پشتبانی : 019930003200',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColor.red,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildContentOfSetting() {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              ButtomSwicherWidget.buttomSwitcher(
                isTrue: _isTrue,
                title: 'تاریک / روشن',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ButtomWidget(
                  title: 'خروج از حساب کاربری',
                  onNext: () async {
                    await AuthManagement.logOut();
                    if (!mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthLoginScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<dynamic> _buildContentButtomSheet(
    BuildContext context, {
    required double height,
    required Widget child,
  }) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: AppColor.white,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          height: height,
          child: child,
        );
      },
    );
  }

  void _changeScreenMethod({toScreen}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => toScreen,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.white,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Transform.scale(
        scale: 1.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 84,
              height: 32,
              child: Stack(
                children: [
                  SvgPicture.asset(AppSvg.logoWithNotBackground),
                  Positioned(
                    top: 3,
                    left: 7,
                    child: Text(
                      'من',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColor.red,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildProfileInfo({
    required BuildContext context,
    required String name,
    required String phone,
    required bool isVaild,
    required String thumbnail,
  }) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 95,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 24, bottom: 32),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightGrey1),
          ),
          child: Row(
            children: [
              buildUserImage(imageUrl: thumbnail),
              const SizedBox(width: 16),
              _buildUserInfo(
                context: context,
                name: name,
                phone: phone,
                isValid: isVaild,
              ),
            ],
          ),
        ),
        Positioned(
          left: 16,
          top: 38,
          child: GestureDetector(
            onTap: () => _buildContentButtomSheet(
              context,
              height: 200,
              child: _buildEditUserinfo(context),
            ),
            child: SvgPicture.asset(AppSvg.editIcon),
          ),
        ),
      ],
    );
  }

  Padding _buildEditUserinfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                InputOwnerComponent(
                  title: 'نام کاربر :',
                  controller: _nameFieldcontroller,
                  textInputType: TextInputType.text,
                ),
                InputOwnerComponent(
                  title: ' شماره موبایل :',
                  controller: _phoneFieldcontroller,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const _PickerPictureComponent(),
                ButtomWidget(
                  title: 'اعمال',
                  width: 80,
                  onNext: () async {
                    BlocProvider.of<ProfileBloc>(context).add(
                      ProfileEditeUserInfo(
                        userId: userId!,
                        name: _nameFieldcontroller.text,
                        phone: _phoneFieldcontroller.text,
                        thumbnail:
                            TemporaryPromotionModel.instance.thumbnailUrl!,
                      ),
                    );

                    BlocProvider.of<ProfileBloc>(context).add(
                      ProfileFetchData(userId: userId),
                    );
                    TemporaryPromotionModel.instance.clear();
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildUserImage({required String? imageUrl}) {
    return Container(
      width: 56,
      height: 56,
      decoration: const ShapeDecoration(
        color: Colors.transparent,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
      ),
      child: ClipPath(
          clipper: ContinuousClipper(),
          child: CachedImage(
            imageUrl: imageUrl,
          )),
    );
  }

  Column _buildUserInfo({
    required BuildContext context,
    required String name,
    required String phone,
    required bool isValid,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColor.black,
              ),
        ),
        Row(
          children: [
            Text(
              phone,
              textDirection: TextDirection.ltr,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColor.black,
                  ),
            ),
            const SizedBox(width: 8),
            ButtomWidget(
              width: 56,
              hight: 30,
              title: isValid ? 'تایید شده' : 'نیاز به تایید',
              fontSize: 10,
              onNext: () {},
            ),
          ],
        ),
      ],
    );
  }

  Padding _buildAppVersionInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'نسخه',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppColor.lightGrey,
                ),
          ),
          Text(
            '1.0.0',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppColor.lightGrey,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> _initializeUser() async {
    userId = await _loadUserId();
    if (userId != null) {
      _profileBloc.add(ProfileFetchData(userId: userId!));
    }
  }

  Future<String?> _loadUserId() async {
    final id = await AuthManagement.readUserId();
    return id;
  }

  @override
  void dispose() {
    _nameFieldcontroller.dispose();
    _phoneFieldcontroller.dispose();
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
    return Container(
      width: 56,
      height: 56,
      decoration: const ShapeDecoration(
        color: AppColor.lightGrey,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
      ),
      child: ClipPath(
        clipper: ContinuousClipper(),
        child: _image != null
            ? Image.file(_image!, fit: BoxFit.cover)
            : GestureDetector(
                onTap: _getImage,
                child: Transform.scale(
                  scale: 0.8,
                  child: SvgPicture.asset(
                    'assets/images/camera-viewfinder.svg',
                  ),
                ),
              ),
      ),
    );
  }
}
