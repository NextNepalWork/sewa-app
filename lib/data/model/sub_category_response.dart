import 'package:json_annotation/json_annotation.dart';
part 'sub_category_response.g.dart';

@JsonSerializable()
class SubCategoryResponse {
  List<SubCategoryDataResponse>? data;
  bool? success;
  int? status;
  SubCategoryResponse(
    this.data,
    this.success,
    this.status,
  );
  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryResponseFromJson(json);
}

@JsonSerializable()
class SubCategoryDataResponse {
  int? id;
  String? name;
  SubSubCategoryResponse? subSubCategories;
  SubCategoryDataResponse(
    this.id,
    this.name,
    this.subSubCategories,
  );
  factory SubCategoryDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryDataResponseFromJson(json);
}

@JsonSerializable()
class SubSubCategoryResponse {
  List<SubSubCategoryDataResponse>? data;
  SubSubCategoryResponse(
    this.data,
  );
  factory SubSubCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$SubSubCategoryResponseFromJson(json);
}

@JsonSerializable()
class SubSubCategoryDataResponse {
  int? id;
  String? name;
  SubSubCategoryDataResponse(
    this.id,
    this.name,
  );
  factory SubSubCategoryDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SubSubCategoryDataResponseFromJson(json);
}
