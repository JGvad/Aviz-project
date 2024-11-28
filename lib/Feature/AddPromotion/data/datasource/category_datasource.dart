import 'package:aviz/Feature/AddPromotion/data/model/category_model.dart';
import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:aviz/UtilNetwork/map_handler.dart';
import 'package:dio/dio.dart';

abstract class ICategoryDatasource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemote extends ICategoryDatasource {
  final Dio _dio;
  CategoryRemote(this._dio);
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final Response response = await _dio.get('/collections/Category/records');
      final List<CategoryModel> categoryList = MapHandler.mapForJsonToModelList(
          response.data['items'], CategoryModel.fromJson);

      return categoryList;
    } on DioException catch (ex) {
      throw ApiException(
        message: ex.response!.data['message'],
        statusCode: ex.response!.statusCode,
      );
    } catch (ex) {
      throw ApiException(message: 'unknown exception', statusCode: 0);
    }
  }
}
