import 'package:aviz/Feature/AddPromotion/data/model/sub_category_model.dart';
import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:aviz/UtilNetwork/map_handler.dart';
import 'package:dio/dio.dart';

abstract class ISubCategoryDatasource {
  Future<List<SubCategoryModel>> getSubCategories(String categoryId);
}

class SubCategoryRemote extends ISubCategoryDatasource {
  final Dio _dio;
  SubCategoryRemote(this._dio);
  @override
  Future<List<SubCategoryModel>> getSubCategories(String categoryId) async {
    Map<String, String> qParams = {'filter': 'category ="$categoryId"'};
    try {
      final Response response = await _dio
          .get('/collections/SubCategory/records', queryParameters: qParams);
      final List<SubCategoryModel> subCategoryList =
          MapHandler.mapForJsonToModelList(
              response.data['items'], SubCategoryModel.fromJson);
      return subCategoryList;
    } on DioException catch (ex) {
      throw ApiException(
          message: ex.response!.data['message'],
          statusCode: ex.response!.statusCode);
    } catch (ex) {
      throw ApiException(message: 'unknown exception', statusCode: 0);
    }
  }
}
