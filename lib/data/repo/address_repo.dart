import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/address_response.dart';
import 'package:sewa_digital/data/model/post_response.dart';

abstract class AddressRepo {
  Future<AddressResponse> fetchAddress();
  Future<DefaultAddressResponse> setDefaultAddress(int addressId);
  Future<PostResponse> deleteAddress(int addressId);
  Future<DefaultAddressResponse> addNewAddress(
      {String? address,
      String? phone,
      String? postalCode,
      String? country,
      String? city,
      String? deliveryLocation});
}

class RealAddressRepo implements AddressRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<DefaultAddressResponse> addNewAddress(
      {String? address,
      String? phone,
      String? postalCode,
      String? country,
      String? city,
      String? deliveryLocation}) {
    return _dataProvider.addAddress(
        address: address,
        phone: phone,
        postalCode: postalCode,
        country: country,
        city: city,
        deliveryLocation: deliveryLocation);
  }

  @override
  Future<AddressResponse> fetchAddress() {
    return _dataProvider.getAddress();
  }

  @override
  Future<DefaultAddressResponse> setDefaultAddress(int addressId) {
    return _dataProvider.getDefaultAddress(addressId);
  }

  @override
  Future<PostResponse> deleteAddress(int addressId) {
    return _dataProvider.deleteAddress(addressId);
  }
}
