class ProductResponse {
  final String id;
  final String name;
  final String description;
  final int price;
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
      price: (json['price'] as num).toDouble(),  
      currency: json['currency'],
      images: json['images'] != null
          ? List<String>.from(json['images'].map((img) => img))
          : [],
    );
  }
}
