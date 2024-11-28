part of 'list_promotion_bloc.dart';

sealed class ListPromotionState {}

final class ListPromotionInitial extends ListPromotionState {}

final class ListPromotionSavedDeleteResponse extends ListPromotionState {
  final Either<String, String> result;
  ListPromotionSavedDeleteResponse(this.result);
}
