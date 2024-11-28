import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Core/data/repository/promotion_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IPromotionRepository _promotionRepository;

  HomeBloc(this._promotionRepository) : super(HomeInitial()) {
    on<HomeFetchData>(
      (event, emit) async {
        emit(HomeLoading());
        final response = await Future.wait([
          _promotionRepository.getHotPromotion(),
          _promotionRepository.getLastestPromotion(),
        ]);
        emit(
          HomeListResponse(
            response[0],
            response[1],
          ),
        );
      },
    );
  }
}
