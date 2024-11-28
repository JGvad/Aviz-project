import 'dart:io';

import 'package:aviz/Feature/AddPromotion/data/datasource/add_promotion_datasource.dart';
import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IAddPromotionRepository {
  Future<Either<String, String>> addPromotion({
    required String title,
    required String description,
    required File thumbnail,
    required String price,
    required String meterage,
    required String roomCount,
    required String floor,
    required String yearBuilt,
    required String location,
    required String subCategoryId,
    required String phoneNumber,
    required bool hasElevator,
    required bool hasParking,
    required bool hasStorage,
    required bool showExactLocation,
    required bool chatEnabled,
    required bool callEnabled,
    required bool isHot,
    required bool hasPool,
    required String userOwner,
  });
}

class AddPromotionRepository extends IAddPromotionRepository {
  final IAddPromotionDatasource _datasource;
  AddPromotionRepository(this._datasource);
  @override
  Future<Either<String, String>> addPromotion({
    required String title,
    required String description,
    required File thumbnail,
    required String price,
    required String meterage,
    required String roomCount,
    required String floor,
    required String yearBuilt,
    required String location,
    required String subCategoryId,
    required String phoneNumber,
    required bool hasElevator,
    required bool hasParking,
    required bool hasStorage,
    required bool showExactLocation,
    required bool chatEnabled,
    required bool callEnabled,
    required bool isHot,
    required String userOwner,
    required bool hasPool,
  }) async {
    try {
      final response = await _datasource.addPromotion(
        title: title,
        description: description,
        thumbnail: thumbnail,
        price: price,
        meterage: meterage,
        roomCount: roomCount,
        floor: floor,
        yearBuilt: yearBuilt,
        location: location,
        subCategoryId: subCategoryId,
        phoneNumber: phoneNumber,
        hasElevator: hasElevator,
        hasParking: hasParking,
        hasStorage: hasStorage,
        showExactLocation: showExactLocation,
        callEnabled: callEnabled,
        chatEnabled: chatEnabled,
        isHot: isHot,
        hasPool: hasPool,
        userOwner: userOwner,
      );
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده');
    }
  }
}
