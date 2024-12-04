class BundleResponse {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final double price;
  final String currency;
  final int? weigth;
  final String? measurement;

  BundleResponse(
      {required this.id,
      required this.name,
      required this.description,
      required this.images,
      required this.price,
      required this.currency,
      this.weigth,
      this.measurement});

  factory BundleResponse.fromJson(Map<String, dynamic> json) {
    return BundleResponse(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        images: json['images'] != null
            ? List<String>.from(json['images'].map((img) => img))
            : [],
        price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price'].toString()) ?? 0.0, // Maneja casos de String o null
        currency: json['currency']);
  }

  static List<BundleResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => BundleResponse.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
