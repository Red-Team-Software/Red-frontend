

class UpdateUserResponse {
  final String id;

  UpdateUserResponse({required this.id});

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
      id: json['userId'] != null ? json['userId'] : '',
    );
  }
}