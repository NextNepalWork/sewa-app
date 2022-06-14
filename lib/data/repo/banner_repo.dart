import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/banner_response.dart';

abstract class BannerRepo {
  Future<BannerResponse> fetchBanner();
  Future<BannerResponse> fetchHomeSlider();
}

class RealBannerRepo implements BannerRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<BannerResponse> fetchBanner() {
    return _dataProvider.getBanners();
  }

  @override
  Future<BannerResponse> fetchHomeSlider() {
    return _dataProvider.getSliders();
  }
}
