part of 'list_promotion_bloc.dart';

class ListPromotionEvent {}

final class DeletSavedPromotionList extends ListPromotionEvent {
  final int index;
  DeletSavedPromotionList(this.index);
}
