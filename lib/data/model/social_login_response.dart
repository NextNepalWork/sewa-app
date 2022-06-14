class FacebookResponse {
  final String? email;
  final String? id;
  final String? name;
  FacebookResponse({this.name, this.id, this.email});
  factory FacebookResponse.fromJson(Map<String, dynamic> json) =>
      FacebookResponse(
          email: json['email'] ?? '',
          name: json['name'] ?? '',
          id: json['id'] ?? '');
}
