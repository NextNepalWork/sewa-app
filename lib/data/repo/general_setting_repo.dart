import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/general_setting_response.dart';

abstract class GeneralSettingRepo {
  Future<GeneralSettingResponse> fetchGeneralSetting();
}

class RealGeneralSettingRepo implements GeneralSettingRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<GeneralSettingResponse> fetchGeneralSetting() {
    return _dataProvider.getGeneralSetting();
  }
}
