class Address {
  final String id;
  final String title;
  final String location;
  final num lat;
  final num lng;

  Address(this.id, this.title, this.location, this.lat, this.lng);

  Address copyWith({String? title, String? location}) {
    return Address(
      id,
      title ?? this.title,
      location ?? this.location,
      lat,
      lng,
    );
  }
}
