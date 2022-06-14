import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/post_response.dart';
import 'package:sewa_digital/data/model/profile_response.dart';

abstract class ProfileRepo {
  Future<ProfileResponse> fetchUser();
  Future<PostResponse> updateUser(
    String name,
    String country,
    String phoneNumber,
    String address,
  );
}

class RealProfileRepo implements ProfileRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<ProfileResponse> fetchUser() {
    return _dataProvider.getUserDetail();
  }

  @override
  Future<PostResponse> updateUser(
    String name,
    String country,
    String phoneNumber,
    String address,
  ) {
    return _dataProvider.updateProfile(
      name,
      country,
      phoneNumber,
      address,
    );
  }
}
