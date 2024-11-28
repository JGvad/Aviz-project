import 'package:aviz/Core/data/models/promotion_hive_model.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';

class PromotionMapper {
  static PromotionModel fromSavedPromotion(SavedPromotion savedPromotion) {
    return PromotionModel(
        collectionName: savedPromotion.collectionName,
        subCategory: savedPromotion.subCategory,
        nameSubCategory: savedPromotion.nameSubCategory,
        creatTime: savedPromotion.creatTime,
        meterage: savedPromotion.meterage,
        roomCount: savedPromotion.roomCount,
        floor: savedPromotion.floor,
        yearBuilt: savedPromotion.yearBuilt,
        hasElevator: savedPromotion.hasElevator,
        hasParking: savedPromotion.hasParking,
        hasStorage: savedPromotion.hasStorage,
        hasPool: savedPromotion.hasPool,
        location: savedPromotion.location,
        showExactLocation: savedPromotion.showExactLocation,
        thumbnailUrl: savedPromotion.thumbnailUrl,
        title: savedPromotion.title,
        description: savedPromotion.description,
        phoneNumber: savedPromotion.phoneNumber,
        chatEnabled: savedPromotion.callEnabled,
        callEnabled: savedPromotion.callEnabled,
        price: savedPromotion.price,
        userOwner: savedPromotion.userOwner);
  }
}
