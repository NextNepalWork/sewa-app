import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:sewa_digital/constant/storage_manager.dart';
import 'package:sewa_digital/data/dataProviders/api_base.dart';
import 'package:sewa_digital/data/dataProviders/api_path.dart';
import 'package:sewa_digital/data/model/delivery_location_response.dart';
import 'package:sewa_digital/data/model/district_response.dart';
import 'package:sewa_digital/data/model/faq_response.dart';
import 'package:sewa_digital/data/model/models.dart';
import 'package:sewa_digital/data/model/notifications_response.dart';
import 'package:sewa_digital/data/model/order_cancel_response.dart';
import 'package:sewa_digital/data/model/order_track_response.dart';
import 'package:sewa_digital/data/model/password_response.dart';
import 'package:sewa_digital/data/model/product_detail_response.dart';
import 'package:sewa_digital/data/model/register_response.dart';
import 'package:sewa_digital/main.dart';

import 'data_log.dart';
import 'dio_exception.dart';

class DataProvider {
  late Dio dio;

  DataProvider() {
    BaseOptions options = BaseOptions(
      receiveTimeout: 30000,
      connectTimeout: 30000,
      validateStatus: (status) => true,
      followRedirects: false,
    );

    dio = Dio(options);

    dio.options.headers.addAll({
      'content-type': 'application/json',
      'authorization': AppSession.accessToken == null
          ? ""
          : 'Bearer ' + AppSession.accessToken.toString()
    });

    dio.interceptors.add(DataLog());
  }
  Future<GeneralSettingResponse> getGeneralSetting() async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.getGeneralSetting));
      if (response.statusCode == 200) {
        return GeneralSettingResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<FAQResponse> getFAQ() async {
    try {
      Response response =
          await dio.get(APIBase.baseUrl + APIPathHelper.getValue(APIPath.faq));
      if (response.statusCode == 200) {
        return FAQResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<NotificationResponse> getNotifications() async {
    try {
      Response response = await dio.get(
        APIBase.baseUrl +
            APIPathHelper.getValue(APIPath.notifications) +
            "/" +
            AppSession.userId.toString(),
      );
      if (response.statusCode == 200) {
        return NotificationResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PostResponse> getPostNotifications() async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.notifications),
          data: jsonEncode({
            "user_id": AppSession.userId.toString(),
            "message": "Thank you for ordering from Sewa Express"
          }),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200) {
        return PostResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PrivacyResponse> getTermsAndConditions() async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.termsAndConditions));
      if (response.statusCode == 200) {
        return PrivacyResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PrivacyResponse> getPrivacyPolicy() async {
    try {
      Response response = await dio
          .get(APIBase.baseUrl + APIPathHelper.getValue(APIPath.privacyPolicy));
      if (response.statusCode == 200) {
        return PrivacyResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PrivacyResponse> getReturnPolicy() async {
    try {
      Response response = await dio
          .get(APIBase.baseUrl + APIPathHelper.getValue(APIPath.returnPolicy));
      if (response.statusCode == 200) {
        return PrivacyResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<AuthResponse> performLogin(String email, String password) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.login),
          data: jsonEncode({"email": email, "password": password}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<AuthResponse> performSocialLogin(
      String name, String email, String provider) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.socialLogin),
          data:
              jsonEncode({"email": email, "name": name, "provider": provider}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<RegisterResponse> performRegister(String fullName, String email,
      String password, String confirmPassword, String phone) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.register),
          data: jsonEncode({
            "email": email,
            "name": fullName,
            "password": password,
            "phone": phone,
            "password_confirmation": confirmPassword
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<AuthResponse> performLogout() async {
    try {
      Response response = await dio.get(
        APIBase.baseUrl + APIPathHelper.getValue(APIPath.logout),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ChangePasswordResponse> updatePassword(
    String password,
    String oldPassword,
  ) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.changePassword),
          data: jsonEncode({"old_password": oldPassword, "password": password}),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ChangePasswordResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ChangePasswordResponse> forgotPassword(String email) async {
    try {
      Response response = await dio.post(
        APIBase.baseUrl + APIPathHelper.getValue(APIPath.forgotPassword),
        data: jsonEncode({"email": email}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ChangePasswordResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<BannerResponse> getBanners() async {
    try {
      Response response = await dio
          .get(APIBase.baseUrl + APIPathHelper.getValue(APIPath.getBanners));
      if (response.statusCode == 200) {
        return BannerResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<BannerResponse> getSliders() async {
    try {
      Response response = await dio
          .get(APIBase.baseUrl + APIPathHelper.getValue(APIPath.homeSlider));
      if (response.statusCode == 200) {
        return BannerResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<CategoryResponse> getCategory() async {
    try {
      Response response = await dio
          .get(APIBase.baseUrl + APIPathHelper.getValue(APIPath.categories));
      if (response.statusCode == 200) {
        return CategoryResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getProducts(int page) async {
    try {
      Response response = await dio.get(
        APIBase.baseUrl +
            APIPathHelper.getValue(APIPath.latestProduct) +
            "?page=$page&size=10",
      );
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<FlashDealResponse> getFlashSale() async {
    try {
      Response response = await dio
          .get(APIBase.baseUrl + APIPathHelper.getValue(APIPath.flashSale));
      if (response.statusCode == 200) {
        return FlashDealResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getFeaturedProducts() async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.featuredProduct));
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getCategoryProducts(
    int id,
    int page,
    String filter,
  ) async {
    var uri = APIBase.baseUrl +
        APIPathHelper.getValue(APIPath.categoryProduct) +
        "$id?page=$page&size=10&scope=$filter";
    try {
      Response response = await dio.get(uri);
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getSubCategoryProducts(
      int id, int page, String filter) async {
    var uri = APIBase.baseUrl +
        APIPathHelper.getValue(APIPath.subCategoryProduct) +
        "$id?page=$page&size=10&scope=$filter";
    try {
      Response response = await dio.get(uri);
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getChildCategoryProducts(
      int id, int page, String filter) async {
    var uri = APIBase.baseUrl +
        APIPathHelper.getValue(APIPath.subSubCategoryProduct) +
        "$id?page=$page&size=10&scope=$filter";
    try {
      Response response = await dio.get(uri);
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<SubCategoryResponse> getSubCategory(
    int id,
  ) async {
    var uri =
        APIBase.baseUrl + APIPathHelper.getValue(APIPath.subCategory) + "$id";
    try {
      Response response = await dio.get(uri);
      if (response.statusCode == 200) {
        return SubCategoryResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<SubCategoryResponse> getChildCategory(
    int id,
  ) async {
    var uri =
        APIBase.baseUrl + APIPathHelper.getValue(APIPath.childCategory) + "$id";
    try {
      Response response = await dio.get(uri);
      if (response.statusCode == 200) {
        return SubCategoryResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductDetailResponse> getProductDetail(
    int id,
  ) async {
    var uri =
        APIBase.baseUrl + APIPathHelper.getValue(APIPath.productDetail) + "$id";
    try {
      Response response = await dio.get(uri,
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200) {
        return ProductDetailResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getRelatedProducts(int id) async {
    try {
      Response response = await dio.get(APIBase.baseUrl +
          APIPathHelper.getValue(APIPath.relatedProduct) +
          "$id");
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ShopResponse> getShopDetail(int id) async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.shopDetail) + "$id");
      if (response.statusCode == 200) {
        return ShopResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getShopFeatured(int id) async {
    try {
      Response response = await dio.get(APIBase.baseUrl +
          APIPathHelper.getValue(APIPath.shopFeatured) +
          "$id");
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getShopNew(int id) async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.shopNew) + "$id");
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getShopTop(int id) async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.shopTop) + "$id");
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getShopAll(int id) async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.shopAll) + "$id");
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getShopBrands(int id) async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.shopBrands) + "$id");
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PostResponse> addToCart(
      {int? productId, int? quantity, String? color, String? variant}) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.addToCart),
          data: jsonEncode({
            "user_id": AppSession.userId,
            "id": productId,
            "quantity": quantity.toString(),
            "color": color,
            "variant": variant!.isEmpty ? null : variant
          }),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PostResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<CartResponse> getFromCart() async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl +
              APIPathHelper.getValue(APIPath.getFromCart) +
              AppSession.userId.toString(),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200) {
        return CartResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PostResponse> deleteFromCart(int cartId) async {
    try {
      Response response = await dio.delete(
          APIBase.baseUrl +
              APIPathHelper.getValue(APIPath.deleteFromCart) +
              cartId.toString(),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PostResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<DefaultAddressResponse> addAddress(
      {String? address,
      String? phone,
      String? postalCode,
      String? country,
      String? city,
      String? deliveryLocation}) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.addAddress),
          data: jsonEncode({
            "address": address,
            "phone": phone,
            "postal_code": postalCode,
            "country": country,
            "city": city,
            "delivery_location": deliveryLocation,
          }),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return DefaultAddressResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<DefaultAddressResponse> getDefaultAddress(int addressId) async {
    try {
      Response response = await dio.get(APIBase.baseUrl +
          APIPathHelper.getValue(APIPath.getDefaultAddress) +
          "$addressId");
      return DefaultAddressResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PostResponse> deleteAddress(int addressId) async {
    try {
      Response response = await dio.delete(
          APIBase.baseUrl +
              APIPathHelper.getValue(APIPath.deleteAddress) +
              "$addressId",
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PostResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<AddressResponse> getAddress() async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.getAddress),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200) {
        return AddressResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ShopResponse> getTopBrand() async {
    try {
      Response response = await dio
          .get(APIBase.baseUrl + APIPathHelper.getValue(APIPath.topBrand));
      if (response.statusCode == 200) {
        return ShopResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getTopBrandProduct(int brandId, int page,
      [int size = 10]) async {
    try {
      Response response = await dio.get(APIBase.baseUrl +
          APIPathHelper.getValue(APIPath.topBrandProduct) +
          brandId.toString() +
          "?page=$page&size=$size");
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProfileResponse> getUserDetail() async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl +
              APIPathHelper.getValue(
                APIPath.getUser,
              ),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200) {
        return ProfileResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PostResponse> updateProfile(
    String name,
    String country,
    String phoneNumber,
    String address,
  ) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.updateUser),
          data: jsonEncode({
            "user_id": AppSession.userId.toString(),
            "name": name,
            "country": country,
            "phone": phoneNumber,
            "address": address,
          }),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PostResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<OrderHistoryResponse> getPurchaseHistory() async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl +
              APIPathHelper.getValue(APIPath.purchaseHistory) +
              AppSession.userId.toString(),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200) {
        return OrderHistoryResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<OrderCancelResponse> cancelOrder(String orderCode) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.cancelOrder),
          data: jsonEncode({"code": orderCode.toString(), "status": "cancel"}),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200) {
        return OrderCancelResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<OrderTrackResponse> getTrackOrder(String orderCode) async {
    String baseUrl = "https://sewaexpress.com/api/";
    try {
      Response response = await dio.get(
        baseUrl +
            APIPathHelper.getValue(APIPath.trackOrder) +
            orderCode.toString(),
      );
      if (response.statusCode == 200) {
        return OrderTrackResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<WishlistResponse> getFromWishlist() async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl +
              APIPathHelper.getValue(APIPath.getWishlist) +
              AppSession.userId.toString(),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200) {
        return WishlistResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PostResponse> addToWishlist(int productId) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.addToWishlist),
          data: jsonEncode({
            "product_id": productId,
            "user_id": AppSession.userId.toString()
          }),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PostResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<CheckWishlistResponse> checkWishlistProduct(int productId) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.checkWishlist),
          data: jsonEncode({
            "product_id": productId,
            "user_id": AppSession.userId.toString()
          }),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CheckWishlistResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PostResponse> deleteWishlistProduct(int wishlistId) async {
    try {
      Response response = await dio.delete(
          APIBase.baseUrl +
              APIPathHelper.getValue(APIPath.deleteWishlist) +
              wishlistId.toString(),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PostResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<HistoryDetailResponse> getPurchaseHistoryDetail(int orderId) async {
    try {
      Response response = await dio.get(
          APIBase.baseUrl +
              APIPathHelper.getValue(APIPath.purchaseHistoryDetail) +
              orderId.toString(),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200) {
        return HistoryDetailResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<VariantResponse> getVariantPrice(
      int id, List choice, String color) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.getVariantPrice),
          data: jsonEncode(
              {"id": id, "choice": json.encode(choice), "color": color}));

      if (response.statusCode == 200) {
        return VariantResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<DistrictResponse> getDistrict() async {
    try {
      Response response = await dio.get(
        APIBase.baseUrl + APIPathHelper.getValue(APIPath.district),
      );
      if (response.statusCode == 200) {
        return DistrictResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<DeliveryLocationResponse> getDeliveryLocation(int id) async {
    try {
      Response response = await dio.get(
        APIBase.baseUrl +
            APIPathHelper.getValue(APIPath.deliveryLocation) +
            id.toString(),
      );
      if (response.statusCode == 200) {
        return DeliveryLocationResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<DeliveryChargeResponse> getDeliveryCharge(int id) async {
    try {
      Response response = await dio.get(
        APIBase.baseUrl +
            APIPathHelper.getValue(APIPath.deliveryCharge) +
            id.toString(),
      );
      if (response.statusCode == 200) {
        return DeliveryChargeResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PlaceOrderResponse> placeOrder({
    String? shippingAddress,
    String? paymentType,
    String? paymentStatus,
    num? grandTotal,
    num? couponDiscount,
  }) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.placeOrder),
          data: jsonEncode(
            {
              "user_id": AppSession.userId,
              "shipping_address": shippingAddress,
              "payment_type": paymentType,
              "payment_status": paymentStatus,
              "grand_total": grandTotal,
              "coupon_discount": couponDiscount
            },
          ),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PlaceOrderResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<PlaceOrderResponse> updateTransaction(
    String? code,
    String? details,
  ) async {
    try {
      Response response = await dio.post(
          APIBase.baseUrl + APIPathHelper.getValue(APIPath.updateTransaction),
          data: jsonEncode({
            "code": code.toString(),
            "details": details.toString(),
          }),
          options: Options(
              headers: ({
            'authorization': 'Bearer ' + AppSession.accessToken.toString()
          })));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PlaceOrderResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getSearchProduct(
      String query, String filter, int page,
      [int size = 10]) async {
    try {
      Response response = await dio.get(APIBase.baseUrl +
          APIPathHelper.getValue(APIPath.searchProduct) +
          "?key=$query&scope=$filter&page=$page&size=$size");
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }

  Future<ProductResponse> getSearchShopProduct(
      String shopId, String filter, int page,
      [int size = 10]) async {
    try {
      Response response = await dio.get(APIBase.baseUrl +
          APIPathHelper.getValue(APIPath.searchShopProduct) +
          "?user_id=$shopId&scope=$filter&page=$page&size=$size");
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw DioException.handleError(
            response.statusCode!, response.statusMessage!);
      }
    } on DioError catch (e) {
      throw DioException.fromDioError(e).toString();
    }
  }
}
