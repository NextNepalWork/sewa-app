import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/category_response.dart';
import 'package:sewa_digital/data/model/sub_category_response.dart';

abstract class CategoryRepo {
  Future<CategoryResponse> fetchCategory();
  Future<SubCategoryResponse> fetchSubCategory(int id);
  Future<SubCategoryResponse> fetchChildCategory(int id);
}

class RealCategoryRepo implements CategoryRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<CategoryResponse> fetchCategory() {
    return _dataProvider.getCategory();
  }

  @override
  Future<SubCategoryResponse> fetchSubCategory(int id) {
    return _dataProvider.getSubCategory(id);
  }

  @override
  Future<SubCategoryResponse> fetchChildCategory(int id) {
    return _dataProvider.getChildCategory(id);
  }
}
