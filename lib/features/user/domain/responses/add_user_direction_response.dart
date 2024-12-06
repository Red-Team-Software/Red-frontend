

class AddUserDirectionResponse {
  final String id;

  AddUserDirectionResponse({
    required this.id,
  });

  factory AddUserDirectionResponse.fromJson(Map<String, dynamic> json) {
    return AddUserDirectionResponse(
      id: json['userId'],
    );
  }

}