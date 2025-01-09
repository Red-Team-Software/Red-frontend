
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String id;
  final String name;
  final String description;
  final double price;
  final String? currency;
  final String? expirationDate;
  final double? weigth;
  final String? measurement;
  final int? inStock;
  final List<String> imageUrl;
  final List<Category> categories;
  final List<Promotion> promotions;


  const Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.expirationDate,
      this.currency,
      this.weigth,
      this.measurement,
      this.inStock,
      this.promotions = const [],
      this.categories = const []
      }
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        expirationDate,
        currency,
        weigth,
        measurement,
        inStock,
        promotions,
        categories,
      ];

}

class Promotion extends Equatable{

  final String id;
  final String? name;
  final double discount;

  const Promotion({required this.id, required this.name, required this.discount});

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        id: json["id"],
        name: json["name"] ?? '',
        discount: json["percentage"]?.toDouble(),
    );
  
  @override
  List<Object> get props => [id, discount];

}