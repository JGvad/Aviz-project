import 'package:aviz/Core/data/models/promotion_hive_model.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Core/data/repository/promotion_repository.dart';
import 'package:aviz/UtilNetwork/auth_management.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'detial_promotion_event.dart';
part 'detial_promotion_state.dart';

class DetialPromotionBloc
    extends Bloc<DetialPromotionEvent, DetialPromotionState> {
  final IPromotionRepository _promotionRepository;
  DetialPromotionBloc(this._promotionRepository)
      : super(DetialPromotionInitial()) {
    on<DetialPromotionSaveData>(
      (event, emit) async {
        String? userId = await AuthManagement.readUserId();

        final result = await _promotionRepository.savePromotion(
          SavedPromotion(
            collectionName: event.promotion.collectionName,
            subCategory: event.promotion.subCategory,
            nameSubCategory: event.promotion.nameSubCategory,
            creatTime: event.promotion.creatTime,
            meterage: event.promotion.meterage,
            roomCount: event.promotion.roomCount,
            floor: event.promotion.floor,
            yearBuilt: event.promotion.yearBuilt,
            hasElevator: event.promotion.hasElevator,
            hasParking: event.promotion.hasParking,
            hasStorage: event.promotion.hasStorage,
            hasPool: event.promotion.hasPool,
            location: event.promotion.location,
            showExactLocation: event.promotion.showExactLocation,
            thumbnailUrl: event.promotion.thumbnailUrl,
            title: event.promotion.title,
            description: event.promotion.description,
            phoneNumber: event.promotion.phoneNumber,
            chatEnabled: event.promotion.chatEnabled,
            callEnabled: event.promotion.callEnabled,
            price: event.promotion.price,
            userOwner: userId,
          ),
        );
        emit(
          DetialPromotionSaveResponse(result),
        );
      },
    );
  }
}
