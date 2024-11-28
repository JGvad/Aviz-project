part of 'search_bloc.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchResponse extends SearchState {
  final Either<String, List<PromotionModel>> result;
  SearchResponse(this.result);
}
