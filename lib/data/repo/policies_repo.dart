import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/privacy_response.dart';

abstract class PoliciesRepo {
  Future<PrivacyResponse> fetchTermsAndConditions();
  Future<PrivacyResponse> fetchReturnPolicies();
  Future<PrivacyResponse> fetchPrivacyPolicies();
}

class RealPoliciesRepo implements PoliciesRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<PrivacyResponse> fetchPrivacyPolicies() {
    return _dataProvider.getPrivacyPolicy();
  }

  @override
  Future<PrivacyResponse> fetchReturnPolicies() {
    return _dataProvider.getReturnPolicy();
  }

  @override
  Future<PrivacyResponse> fetchTermsAndConditions() {
    return _dataProvider.getTermsAndConditions();
  }
}
