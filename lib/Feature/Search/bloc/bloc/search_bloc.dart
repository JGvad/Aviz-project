import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Core/data/repository/promotion_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IPromotionRepository _iPromotionRepository;
  SearchBloc(this._iPromotionRepository) : super(SearchInitial()) {
    on<SearchWithQeury>(
      (event, emit) async {
        emit(SearchLoading());
        final result =
            await _iPromotionRepository.getQueryPromotion(event.qeury);
        emit(
          SearchResponse(result),
        );
      },
    );
  }
}
