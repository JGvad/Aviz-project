import 'package:aviz/Feature/AddPromotion/data/datasource/sub_category_datasource.dart';
import 'package:aviz/Feature/AddPromotion/data/model/sub_category_model.dart';
import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ISubCategoryRepository {
  Future<Either<String, List<SubCategoryModel>>> subCategories(
      String categoryId);
}

class SubCategoryRepository extends ISubCategoryRepository {
  final ISubCategoryDatasource _subCategoryDatasource;
  SubCategoryRepository(this._subCategoryDatasource);
  @override
  Future<Either<String, List<SubCategoryModel>>> subCategories(
      String categoryId) async {
    try {
      final List<SubCategoryModel> subCategoryList =
          await _subCategoryDatasource.getSubCategories(categoryId);
      return right(subCategoryList);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا  تعریف نشده');
    }
  }
}
