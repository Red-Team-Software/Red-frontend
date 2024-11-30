class ProductResponse {
  final String id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final List<String> images;

  ProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.images,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price'].toString()) ?? 0.0, // Maneja casos de String o null,  
      currency: json['currency'],
      images: json['images'] != null
          ? List<String>.from(json['images'].map((img) => img))
          : [],
    );
  }

}
