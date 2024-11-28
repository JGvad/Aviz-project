import 'package:aviz/Core/data/models/promotion_hive_model.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:aviz/UtilNetwork/hive_exception.dart';
import 'package:aviz/UtilNetwork/map_handler.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IPromotionDatasource {
  Future<List<PromotionModel>> getHotPromotion();
  Future<List<PromotionModel>> getLatestPromotion();
  Future<List<PromotionModel>> getQueryPromotion(String query);

  Future<bool> savePromotion({required SavedPromotion promotion});
  Future<List<SavedPromotion>> getSavedPromotion({required String ownerId});
  Future<String> deletSavedPromotion(int index);
  Future<List<PromotionModel>> getUserPromotion({required String ownerId});
}

class PromotionRemote extends IPromotionDatasource {
  final Box<SavedPromotion> _savedBox;
  final Dio _dio;
  PromotionRemote(this._dio, this._savedBox);

  @override
  Future<List<PromotionModel>> getHotPromotion() async {
    const Map<String, String> promotionQuery = {
      'filter': 'isHot = true',
      'expand': 'subCategory'
    };

    try {
      final Response response = await _dio.get('/collections/Prmotion/records',
          queryParameters: promotionQuery);
      final List<PromotionModel> hotPromotionList =
          MapHandler.mapForJsonToModelList(
              response.data['items'], PromotionModel.fromJson);
      return hotPromotionList;
    } on DioException catch (ex) {
      throw ApiException(
          message: ex.response?.data['message'],
          statusCode: ex.response?.statusCode);
    } catch (ex) {
      throw ApiException(message: 'unknown exception', statusCode: 0);
    }
  }

  @override
  Future<List<PromotionModel>> getLatestPromotion() async {
    const Map<String, String> promotionQuery = {
      'filter': 'isHot = false',
      'expand': 'subCategory'
    };

    try {
      final Response response = await _dio.get('/collections/Prmotion/records',
          queryParameters: promotionQuery);
      final List<PromotionModel> latestPromotionList =
          MapHandler.mapForJsonToModelList(
              response.data['items'], PromotionModel.fromJson);
      return latestPromotionList;
    } on DioException catch (ex) {
      throw ApiException(
          message: ex.response?.data['message'],
          statusCode: ex.response?.statusCode);
    } catch (ex) {
      throw ApiException(message: 'unknown exception', statusCode: 0);
    }
  }

  @override
  Future<bool> savePromotion({required SavedPromotion promotion}) async {
    try {
      await _savedBox.add(promotion);
      return true;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  @override
  Future<List<SavedPromotion>> getSavedPromotion(
      {required String ownerId}) async {
    try {
      final List<SavedPromotion> savedPrmotions = _savedBox.values
          .where((elemnt) => elemnt.userOwner == ownerId)
          .toList();
      return savedPrmotions;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  @override
  Future<List<PromotionModel>> getUserPromotion(
      {required String ownerId}) async {
    final Map<String, String> promotionQuery = {
      'filter': 'userOwner = "$ownerId"',
      'expand': 'subCategory'
    };

    try {
      final Response response = await _dio.get('/collections/Prmotion/records',
          queryParameters: promotionQuery);

      final List<PromotionModel> latestPromotionList =
          MapHandler.mapForJsonToModelList(
              response.data['items'], PromotionModel.fromJson);
      return latestPromotionList;
    } on DioException catch (ex) {
      throw ApiException(
        message: ex.response?.data['message'],
        statusCode: ex.response?.statusCode,
      );
    } catch (ex) {
      throw ApiException(message: 'unknown exception', statusCode: 0);
    }
  }

  @override
  Future<String> deletSavedPromotion(int index) async {
    try {
      await _savedBox.deleteAt(index);
      return 'اگهی از لیست حذف شد';
    } catch (ex) {
      throw HiveException(message: 'مشکلی پیش امده');
    }
  }

  @override
  Future<List<PromotionModel>> getQueryPromotion(String query) async {
    final Map<String, String> searchQuery = {
      'filter': 'title ~ "$query"',
      'expand': 'subCategory'
    };

    try {
      final Response response = await _dio.get('/collections/Prmotion/records',
          queryParameters: searchQuery);
      final List<PromotionModel> promotionList =
          MapHandler.mapForJsonToModelList(
              response.data['items'], PromotionModel.fromJson);
      return promotionList;
    } on DioException catch (ex) {
      throw ApiException(
          message: ex.response?.data['message'],
          statusCode: ex.response?.statusCode);
    } catch (ex) {
      throw ApiException(message: 'unknown exception', statusCode: 0);
    }
  }
}
