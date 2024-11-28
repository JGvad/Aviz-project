import 'package:aviz/Constants/color_constant.dart';
import 'package:aviz/Constants/image_constant.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Feature/DetialPromotion/view/detial_promotion_screen.dart';
import 'package:aviz/Feature/Search/bloc/bloc/search_bloc.dart';
import 'package:aviz/Widgets/empty_content_widget.dart';
import 'package:aviz/Widgets/lastest_promotion_widget.dart';
import 'package:aviz/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  bool isWiting = false;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: _buildAppBar(context),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchResponse) {
                return state.result.fold(
                  (exception) => Text(exception),
                  (promotionList) => promotionList.isEmpty
                      ? _buildIfEmpty(context)
                      : _buildIfNotEmpty(promotionList),
                );
              } else {
                return Center(
                  child: EmptyContent(
                    title: "هر چیزی که دنبالش هستید، جستجو کنید !",
                    widget: SvgPicture.asset(AppSvg.searchIcon),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  ListView _buildIfNotEmpty(List<PromotionModel> promotionList) {
    return ListView.builder(
      itemCount: promotionList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetialPromotionScreen(
              prmotion: promotionList[index],
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: 17,
            left: 17,
          ),
          child: LastestPromotionCard(
            promotion: promotionList[index],
          ),
        ),
      ),
    );
  }

  Widget _buildIfEmpty(BuildContext context) {
    return EmptyContent(
      title:
          'فعلاً اینجا چیزی نیست...\nاما شاید دفعه بعد به چیزی که می‌خواهید برسید. جستجوی دیگری امتحان کنید!',
      widget: SvgPicture.asset(
        AppSvg.notFoundIcon,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 3,
      automaticallyImplyLeading: false,
      shadowColor: AppColor.lightGrey1,
      backgroundColor: AppColor.white,
      surfaceTintColor: Colors.transparent,
      title: Directionality(
        textDirection: TextDirection.rtl,
        child: AvizTextFiledWidget(
          controller: _controller,
          hintText: "جستجو ...",
          hintSize: 16,
          onchanged: (value) {
            setState(() {
              isWiting = true;
            });
          },
          onSubmitted: (value) {
            context.read<SearchBloc>().add(SearchWithQeury(_controller.text));
          },
          keyboardType: TextInputType.text,
          textinputAction: TextInputAction.search,
          defaultFillColor: Colors.transparent,
          minLine: 1,
          maxLength: 60,
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(AppSvg.arrowRightIcon),
        onPressed: () {},
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      actions: [
        Visibility(
          visible: isWiting,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: IconButton(
              icon: SvgPicture.asset(AppSvg.closeIcon),
              splashColor: Colors.transparent,
              onPressed: () {
                _controller.clear();
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
