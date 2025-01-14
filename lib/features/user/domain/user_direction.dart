class UserDirection {
  String id;
  String addressName;
  String direction;
  num latitude;
  num longitude;
  bool isFavorite;

  UserDirection({
    required this.id,
    required this.addressName,
    required this.direction,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });

  factory UserDirection.fromJson(Map<String, dynamic> json) {
    return UserDirection(
      id: json['id'],
      direction: json['direction'],
      longitude: json['long'],
      latitude: json['lat'],
      addressName: json['name'],
      isFavorite: json['favorite'],
    );
  }

  static List<UserDirection> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserDirection.fromJson(json)).toList();
  }
}