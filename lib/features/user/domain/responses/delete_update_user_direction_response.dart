

class DeleteUpdateUserDirectionResponse {
  final String id;
  final String name;
  final bool favorite;
  final num lat;
  final num lng;
  final String direction;

  DeleteUpdateUserDirectionResponse({
    required this.id,
    required this.name,
    required this.favorite,
    required this.lat,
    required this.lng,
    required this.direction,
  });

  factory DeleteUpdateUserDirectionResponse.fromJson(Map<String, dynamic> json) {
    return DeleteUpdateUserDirectionResponse(
      id: json['id'],
      name: json['name'],
      direction: json['direction'],
      favorite: json['favorite'],
      lat: json['lat'],
      lng: json['long'],
    );
  }

}