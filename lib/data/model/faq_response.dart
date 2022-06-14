import 'package:json_annotation/json_annotation.dart';
part 'faq_response.g.dart';

@JsonSerializable()
class FAQResponse {
  bool? success;
  int? status;
  List<FAQDataResponse>? data;
  FAQResponse(this.success, this.status, this.data);
  factory FAQResponse.fromJson(Map<String, dynamic> json) =>
      _$FAQResponseFromJson(json);
}

class FAQDataResponse {
  int? id;
  String? title;
  int? published;
  String? description;
  FAQDataResponse(this.id, this.title, this.published, this.description);
  factory FAQDataResponse.fromJson(Map<String, dynamic> json) =>
      _$FAQDataResponseFromJson(json);
}
