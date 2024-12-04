class UserDirection {
  String addressName;
  num latitude;
  num longitude;
  bool isFavorite;

  UserDirection({
    required this.addressName,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });

  factory UserDirection.fromJson(Map<String, dynamic> json) {
    return UserDirection(
      addressName: json['addressName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isFavorite: json['isFavorite'],
    );
  }
}
