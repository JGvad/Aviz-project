import 'package:aviz/Feature/AddPromotion/data/datasource/category_datasource.dart';
import 'package:aviz/Feature/AddPromotion/data/model/category_model.dart';
import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<CategoryModel>>> getCategories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDatasource _categoryDatasource;
  CategoryRepository(this._categoryDatasource);
  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final List<CategoryModel> categoryList =
          await _categoryDatasource.getCategories();
      return right(categoryList);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده');
    }
  }
}
