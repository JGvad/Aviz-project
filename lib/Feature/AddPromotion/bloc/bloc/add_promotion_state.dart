part of 'add_promotion_bloc.dart';

sealed class AddPromotionState {}

final class AddPromotionInitial extends AddPromotionState {}

final class AddPromotionLoding extends AddPromotionState {}

final class AddPromotionCategoryResponse extends AddPromotionState {
  final Either<String, List<CategoryModel>> categoryList;

  AddPromotionCategoryResponse({required this.categoryList});
}

final class AddPromotionSubCategoryResponse extends AddPromotionState {
  final Either<String, List<SubCategoryModel>> subcategoryList;

  AddPromotionSubCategoryResponse({required this.subcategoryList});
}

final class AddPromotionResponse extends AddPromotionState {
  final Either<String, String> response;
  AddPromotionResponse({required this.response});
}
