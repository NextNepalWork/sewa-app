import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/faq_response.dart';

abstract class FAQRepo {
  Future<FAQResponse> getFAQ();
}

class RealFAQRepo implements FAQRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<FAQResponse> getFAQ() {
    return _dataProvider.getFAQ();
  }
}
