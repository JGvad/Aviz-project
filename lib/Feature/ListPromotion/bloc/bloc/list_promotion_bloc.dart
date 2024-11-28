import 'package:aviz/Core/data/repository/promotion_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'list_promotion_event.dart';
part 'list_promotion_state.dart';

class ListPromotionBloc extends Bloc<ListPromotionEvent, ListPromotionState> {
  final IPromotionRepository _promotionRepository;
  ListPromotionBloc(this._promotionRepository) : super(ListPromotionInitial()) {
    on<DeletSavedPromotionList>(
      (event, emit) async {
        final result =
            await _promotionRepository.deleteSavedPromotion(event.index);
        emit(ListPromotionSavedDeleteResponse(result));
      },
    );
  }
}
