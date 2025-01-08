import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:equatable/equatable.dart';

class Bundle extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final double? weight;
  final String? measurement;
  final String? expirationDate;
  final int? inStock;
  final List<String> imageUrl;
  final List<Category> categories;
  final List<Promotion> promotions;
  final List<BundleProduct> products;


  const Bundle(
      {required this.id,
      required this.name,
      this.description = "",
      required this.imageUrl,
      required this.price,
      required this.currency,
      this.weight,
      this.measurement,
      this.inStock,
      this.expirationDate,
      this.categories = const [],
      this.promotions = const [],
      this.products = const []
      });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
        currency,
        weight,
        measurement,
        inStock,
        expirationDate,
        categories,
        promotions,
        products
      ];
}

class BundleProduct extends Equatable{
  final String id;
  final String name;

  const BundleProduct({required this.id, required this.name});
  
  @override
  List<Object> get props => [id, name];

  
  factory BundleProduct.fromJson(Map<String, dynamic> json) => BundleProduct(
        id: json["id"],
        name: json["name"],
    );
}

class Promotion extends Equatable{

  final String id;
  // final String name;
  final double percentage;

  const Promotion({required this.id,  required this.percentage});

  
  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        id: json["id"],
        // name: json["name"],
        percentage: json["discount"]?.toDouble(),
    );
  
  @override
  List<Object> get props => [id, percentage];

}