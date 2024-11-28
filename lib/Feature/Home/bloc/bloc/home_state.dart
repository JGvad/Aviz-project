part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeListResponse extends HomeState {
  final Either<String, List<PromotionModel>> getHotPrmotions;
  final Either<String, List<PromotionModel>> getLastestPrmotions;
  HomeListResponse(this.getHotPrmotions, this.getLastestPrmotions);
}
