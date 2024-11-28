part of 'search_bloc.dart';

sealed class SearchEvent {}

final class SearchWithQeury extends SearchEvent {
  final String qeury;
  SearchWithQeury(this.qeury);
}
