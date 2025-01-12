import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/infraestructure/models/category_response.dart';
import 'package:GoDeli/features/products/domain/product.dart';

class ProductResponse {
  final String id;
  final String name;
  final String description;
  final List<String> image;
  final double price;
  final String currency;
  final double? weigth;
  final String? measurement;
  final int? stock;
  final String? caducityDate;
  final List<CategoryProduct> categories;
  final List<Promotion> promotion;

  ProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    this.caducityDate, 
    this.stock, 
    this.weigth, 
    this.measurement, 
    this.categories = const [], 
    this.promotion = const [],
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json, {String id = ''}) {
    return ProductResponse(
      id: json['id'] ?? id,
      name: json['name'],
      description: json['description'] ?? '',
      image: json['images'] != null
            ? List<String>.from(json['images'].map((img) => img))
            : [],
      price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price'].toString()) ?? 0.0,
      currency: json['currency'],
      weigth: json['weight'] is int
          ? json['weight'].toDouble()
          : json['weight'] is double
          ? json['weight']
          : double.tryParse(json['weight'].toString()) ?? 0.0,
      measurement: json['measurement'],
      stock: json['stock'],
      caducityDate: json['caducityDate'],
      categories: json['category'] != null ? List<CategoryProduct>.from(json["category"].map((c) => CategoryProduct.fromJson(c))) : [],
      promotion: json['discount'] != null ? List<Promotion>.from(json["discount"].map((x) => Promotion.fromJson(x))) : []
    );
  }

  static List<ProductResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductResponse.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
