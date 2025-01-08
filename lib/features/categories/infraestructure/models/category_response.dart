


import 'package:GoDeli/features/categories/domain/category.dart';

class CategoryResponse {
  final String id;
  final String name;
  final String icon;
  CategoryResponse({required this.id, required this.name, this.icon = ''});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        id: json["categoryId"],
        name: json["categoryName"],
        icon: json["categoryImage"] ?? '',
    );
  
  factory CategoryResponse.fromProductJson(Map<String, dynamic> json) => CategoryResponse(
        id: json["id"],
        name: json["name"],
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