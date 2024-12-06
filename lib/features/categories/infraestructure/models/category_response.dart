


import 'package:GoDeli/features/categories/domain/category.dart';

class CategoryResponse {
  final String id;
  final String name;
  final String icon;
  CategoryResponse({required this.id, required this.name, required this.icon});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        id: json["id"],
        name: json["name"],
        icon: json["discount"],
    );
  
  static Category categoryToDomain(CategoryResponse json){
    return Category(id: json.id, name: json.name, icon: json.icon);
  }
}