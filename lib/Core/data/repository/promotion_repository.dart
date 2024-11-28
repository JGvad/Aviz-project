import 'package:aviz/Core/data/datasource/promotion_datasource.dart';
import 'package:aviz/Core/data/models/promotion_hive_model.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:aviz/UtilNetwork/hive_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IPromotionRepository {
  Future<Either<String, List<PromotionModel>>> getHotPromotion();
  Future<Either<String, List<PromotionModel>>> getLastestPromotion();
  Future<Either<String, List<PromotionModel>>> getQueryPromotion(String qeury);
  Future<Either<bool, bool>> savePromotion(SavedPromotion promotion);
  Future<Either<String, String>> deleteSavedPromotion(int index);
  Future<Either<String, List<SavedPromotion>>> getSavedPromotions(
      {required String ownerId});
  Future<Either<String, List<PromotionModel>>> getUserPromotions(
      {required String ownerId});
}

class PromotionRepository extends IPromotionRepository {
  final IPromotionDatasource _promotionDatasource;
  PromotionRepository(this._promotionDatasource);
  @override
  Future<Either<String, List<PromotionModel>>> getHotPromotion() async {
    try {
      final List<PromotionModel> promotionList =
          await _promotionDatasource.getHotPromotion();
      return right(promotionList);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده است');
    }
  }

  @override
  Future<Either<String, List<PromotionModel>>> getLastestPromotion() async {
    try {
      final List<PromotionModel> promotionList =
          await _promotionDatasource.getLatestPromotion();
      return right(promotionList);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده است');
    }
  }

  @override
  Future<Either<bool, bool>> savePromotion(SavedPromotion promotion) async {
    try {
      await _promotionDatasource.savePromotion(promotion: promotion);
      return right(true);
    } catch (ex) {
      return left(false);
    }
  }

  @override
  Future<Either<String, List<SavedPromotion>>> getSavedPromotions(
      {required String ownerId}) async {
    try {
      final List<SavedPromotion> savedPromotions =
          await _promotionDatasource.getSavedPromotion(ownerId: ownerId);
      return right(savedPromotions);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده است');
    }
  }

  @override
  Future<Either<String, List<PromotionModel>>> getUserPromotions(
      {required String ownerId}) async {
    try {
      final List<PromotionModel> userPromotion =
          await _promotionDatasource.getUserPromotion(ownerId: ownerId);
      return right(userPromotion);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده است');
    }
  }

  @override
  Future<Either<String, String>> deleteSavedPromotion(int index) async {
    try {
      final result = await _promotionDatasource.deletSavedPromotion(index);
      return right(result);
    } on HiveException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<PromotionModel>>> getQueryPromotion(
      String qeury) async {
    try {
      final List<PromotionModel> promotionList =
          await _promotionDatasource.getQueryPromotion(qeury);
      return right(promotionList);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده است');
    }
  }
}
