import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/infraestructure/models/category_response.dart';
import 'package:GoDeli/features/products/domain/product.dart';

class ProductResponse {
  final String id;
  final String description;
  final String? caducityDate;
  final String name;
  final int? stock;
  final List<String> images;
  final double price;
  final String currency;
  final double? weigth;
  final String? measurement;
  final List<Category> categories;
  final List<Promotion> promotion;


  ProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.images,
    this.caducityDate, 
    this.stock, 
    this.weigth, 
    this.measurement, 
    this.categories = const [], 
    this.promotion = const [],

  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'],
      description: json['description'],
      caducityDate: json['caducityDate'],
      name: json['name'],
      stock: json['stock'],
      images: json['images'] != null
            ? List<String>.from(json['images'].map((img) => img))
            : [],
      price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price'].toString()) ?? 0.0, // Maneja casos de String o null,  
      currency: json['currency'],
      weigth: json['weigth'] is int
          ? json['weigth'].toDouble()
          : json['weigth'] is double
          ? json['weigth']
          : double.tryParse(json['weigth'].toString()) ?? 0.0,
      measurement: json['measurement'],
      categories: json['categories'] != null ? List<Category>.from(json["categories"].map((x) => CategoryResponse.categoryToDomain(CategoryResponse.fromJson(json)))): [],
      promotion: json['promotion'] != null ? List<Promotion>.from(json["promotion"].map((x) => Promotion.fromJson(x))) : []
    );
  }

  static List<ProductResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductResponse.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
