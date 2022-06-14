import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/variant_response.dart';

abstract class VariantRepo {
  Future<VariantResponse> fetchVariantPrice(int id, List choice, String color);
}

class RealVariantRepo implements VariantRepo {
  final DataProvider _dataProvider = DataProvider();

  @override
  Future<VariantResponse> fetchVariantPrice(int id, List choice, String color) {
    return _dataProvider.getVariantPrice(id, choice, color);
  }
}
