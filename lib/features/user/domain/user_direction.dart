class UserDirection {
  String id;
  String addressName;
  String address;
  num latitude;
  num longitude;
  bool isFavorite;

  UserDirection({
    required this.id,
    required this.addressName,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });

  factory UserDirection.fromJson(Map<String, dynamic> json) {
    return UserDirection(
      id: json['id'],
      addressName: json['name'],
      address: json['address'],
      latitude: json['lat'],
      longitude: json['lng'],
      isFavorite: json['favorite'],
    );
  }

  static List<UserDirection> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserDirection.fromJson(json)).toList();
  }
}