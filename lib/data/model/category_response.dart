import 'package:json_annotation/json_annotation.dart';
part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  List<CategoryDataResponse>? data;
  bool? success;
  int? status;
  CategoryResponse(this.data, this.success, this.status);
  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}

@JsonSerializable()
class CategoryDataResponse {
  int? id;
  String? name;
  String? banner;
  String? icon;
  CategoryDataResponse(this.id, this.name, this.banner, this.icon);
  factory CategoryDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataResponseFromJson(json);
}
