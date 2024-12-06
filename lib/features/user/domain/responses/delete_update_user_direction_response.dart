

class DeleteUpdateUserDirectionResponse {
  final String id;

  DeleteUpdateUserDirectionResponse({
    required this.id,
  });

  factory DeleteUpdateUserDirectionResponse.fromJson(Map<String, dynamic> json) {
    return DeleteUpdateUserDirectionResponse(
      id: json['userId'],
    );
  }

}