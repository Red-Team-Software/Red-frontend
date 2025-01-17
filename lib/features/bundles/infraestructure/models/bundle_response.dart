import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/products/domain/product.dart';

class BundleResponse {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final double price;
  final String currency;
  final double? weight;
  final String? measurement;
  final int? stock;
  final String? caducityDate;
  final List<CategoryProduct> categories;
  final List<Promotion> promotion;
  final List<BundleProduct> products;

  BundleResponse({
    required this.id,
    required this.name,
    this.description = '',
    required this.images,
    required this.price,
    required this.currency,
    this.weight,
    this.measurement,
    this.stock,
    this.caducityDate,
    this.categories = const [],
    this.promotion = const [],
    this.products = const [],
  });

  factory BundleResponse.fromJson(Map<String, dynamic> json, {String id = ''}) {
    return BundleResponse(
      id: json['id'] ?? id,
      name: json['name'],
      description: json['description'] ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'].map((img) => img))
          : [],
      price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price'].toString()) ??
              0.0, // Maneja casos de String o null
      currency: json['currency'],
      weight: json['weight'] is int
          ? json['weight'].toDouble()
          : json['weight'] is double
              ? json['weight']
              : double.tryParse(json['weight'].toString()) ?? 0.0,
      measurement: json['measurement'],
      stock: json['stock'],
      categories: json['category'] != null
          ? List<CategoryProduct>.from(json["category"].map((x) =>
              CategoryProduct.fromJson(x))) // Mapea la lista de categorias
          : [],
      promotion: json['discount'] != null
          ? List<Promotion>.from(
              json["discount"].map((x) => Promotion.fromJson(x)))
          : [],
      products: json['product'] != null
          ? List<BundleProduct>.from(
              json['product'].map((x) => BundleProduct.fromJson(x)))
          : [],
    );
  }

  static List<BundleResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => BundleResponse.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
