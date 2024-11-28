part of 'add_promotion_bloc.dart';

sealed class AddPromotionEvent {}

final class AddPromotionCategoryRequest extends AddPromotionEvent {}

final class AddPromotionSubCategoryRequest extends AddPromotionEvent {
  final String categoryId;
  AddPromotionSubCategoryRequest(this.categoryId);
}

final class AddPromotionRequest extends AddPromotionEvent {
  final String title;
  final String description;
  final File thumbnail;
  final String price;
  final String meterage;
  final String roomCount;
  final String floor;
  final String yearBuilt;
  final String location;
  final String subCategoryId;
  final String phoneNumber;
  final bool hasElevator;
  final bool hasParking;
  final bool hasStorage;
  final bool showExactLocation;
  final bool chatEnabled;
  final bool callEnabled;
  final bool isHot;
  final bool hasPool;
  final String userOwner;
  AddPromotionRequest(
      {required this.title,
      required this.description,
      required this.thumbnail,
      required this.price,
      required this.meterage,
      required this.roomCount,
      required this.floor,
      required this.yearBuilt,
      required this.location,
      required this.subCategoryId,
      required this.phoneNumber,
      required this.hasElevator,
      required this.hasParking,
      required this.hasStorage,
      required this.showExactLocation,
      required this.chatEnabled,
      required this.callEnabled,
      required this.isHot,
      required this.hasPool,
      required this.userOwner});
}
