


import 'package:GoDeli/features/categories/domain/category.dart';

class CategoryResponse {
  final String id;
  final String name;
  final String icon;
  final List<ItemCategory> products;
  final List<ItemCategory> bundles;
  CategoryResponse({required this.id, required this.name, this.icon = '', this.products = const [], this.bundles = const []});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        id: json["categoryId"],
        name: json["categoryName"],
        icon: json["categoryImage"] ?? '',
    );
  
  factory CategoryResponse.fromProductJson(Map<String, dynamic> json) => CategoryResponse(
        id: json["id"],
        name: json["name"],
    );

  factory CategoryResponse.fromCatalogJson(Map<String, dynamic> json) => CategoryResponse(
        id: json["id"],
        name: json["name"],
        products: json['products'] != null ? List<ItemCategory>.from(json["products"].map((x) => ItemCategory(
          id: x['id'],
          name: x['name'],
          imageUrl: x['images'] != null ? x['images'][0] : '',
          price: x['price'] is double ? x['price'] : double.tryParse(x['price'].toString()) ?? 0.0,
        ))) : [],
        bundles: json['bundles'] != null ? List<ItemCategory>.from(json["bundles"].map((x) => ItemCategory(
          id: x['id'],
          name: x['name'],
          imageUrl: x['images'] != null ? x['images'][0] : '',
          price: x['price'] is double ? x['price'] : double.tryParse(x['price'].toString()) ?? 0.0,
        ))) : []
    );

  static Category categoryToDomain(CategoryResponse json){
    return Category(id: json.id, name: json.name, icon: json.icon);
  }

  static List<CategoryResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CategoryResponse.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}