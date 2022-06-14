import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/delivery_location_response.dart';
import 'package:sewa_digital/data/model/district_response.dart';

abstract class DeliveryLocationRepo {
  Future<DistrictResponse> getDistrict();
  Future<DeliveryLocationResponse> getDeliveryLocation(int id);
  Future<DeliveryChargeResponse> getDeliveryCharge(int id);
}

class RealDeliveryLocationRepo implements DeliveryLocationRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<DeliveryLocationResponse> getDeliveryLocation(int id) {
    return _dataProvider.getDeliveryLocation(id);
  }

  @override
  Future<DistrictResponse> getDistrict() {
    return _dataProvider.getDistrict();
  }

  @override
  Future<DeliveryChargeResponse> getDeliveryCharge(int id) {
    return _dataProvider.getDeliveryCharge(id);
  }
}
