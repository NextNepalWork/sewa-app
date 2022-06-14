import 'package:json_annotation/json_annotation.dart';
part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  String? message;
  PostResponse(this.message);
  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);
}
