

class UpdateUserDirectionResponse {
  final String id;
  final String direction;
  final bool favorite;
  final num lat;
  final num lng;
  final String name;

  UpdateUserDirectionResponse({
    required this.id,
    required this.name,
    required this.favorite,
    required this.lat,
    required this.lng,
    required this.direction,
  });

  //TODO: Implement ToNum en lat y long
  factory UpdateUserDirectionResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserDirectionResponse(
      id: json['id'],
      direction: json['direction'],
      favorite: json['favorite'],
      lat: num.parse(json['lat']),
      lng: num.parse(json['long']),
      name: json['name'],
    );
  }

}