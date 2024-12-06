import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/infraestructure/models/category_response.dart';

class BundleResponse {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final double price;
  final String currency;
  final double? weigth;
  final String? measurement;
  final int? stock;
  final String? caducityDate;
  final List<Category> categories;
  final List<Promotion> promotion;
  final List<BundleProduct> products;

  BundleResponse(
      {required this.id,
      required this.name,
      required this.description,
      required this.images,
      required this.price,
      required this.currency,
      this.weigth,
      this.measurement,
      this.stock, 
      this.caducityDate, 
      this.categories = const [], 
      this.promotion = const [], 
      this.products = const [], });

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
        currency: json['currency'],
        weigth: json['weigth'] is int
          ? json['weigth'].toDouble()
          : json['weigth'] is double
          ? json['weigth']
          : double.tryParse(json['weigth'].toString()) ?? 0.0,
        measurement: json['measurement'],
        stock: json['stock'],
        categories: json['categories'] != null ? List<Category>.from(json["categories"].map((x) => CategoryResponse.categoryToDomain(CategoryResponse.fromJson(json)))): [],
        promotion: json['promotion'] != null ? List<Promotion>.from(json["promotion"].map((x) => Promotion.fromJson(x))) : [],
        products: json['products'] != null
            ? List<BundleProduct>.from(json['products'].map((x) => BundleProduct.fromJson(json)))
            : [],
        );
  }

  static List<BundleResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => BundleResponse.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
