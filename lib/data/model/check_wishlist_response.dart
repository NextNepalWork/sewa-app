// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'check_wishlist_response.g.dart';

@JsonSerializable()
class CheckWishlistResponse {
  String? message;
  bool? is_in_wishlist;
  int? product_id;
  int? wishlist_id;
  CheckWishlistResponse(
    this.message,
    this.is_in_wishlist,
    this.product_id,
    this.wishlist_id,
  );
  factory CheckWishlistResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckWishlistResponseFromJson(json);
}
