class Address {
  final String title;
  final String location;

  Address(this.title, this.location);

  Address copyWith({String? title, String? location}) {
    return Address(
      title ?? this.title,
      location ?? this.location,
    );
  }
}
