part of 'detial_promotion_bloc.dart';

sealed class DetialPromotionState {}

final class DetialPromotionInitial extends DetialPromotionState {}

final class DetialPromotionLoding extends DetialPromotionState {}

final class DetialPromotionSaveResponse extends DetialPromotionState {
  final Either<bool, bool> result;
  DetialPromotionSaveResponse(this.result);
}
