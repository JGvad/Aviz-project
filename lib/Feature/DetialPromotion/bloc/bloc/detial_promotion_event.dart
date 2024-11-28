part of 'detial_promotion_bloc.dart';

sealed class DetialPromotionEvent {}

final class DetialPromotionSaveData extends DetialPromotionEvent {
  final PromotionModel promotion;
  DetialPromotionSaveData(this.promotion);
}
