import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/infraestructure/models/category_response.dart';


class CategoryMapper {
  static Category categoryToDomian(CategoryResponse json) {
    return Category(
      id: json.id,
      name: json.name,
      icon: json.icon,
    );
  }

  static Future<Category> categoryItemsToDomian(CategoryResponse json) {
    return Future.value(Category(
      id: json.id,
      name: json.name,
      icon: json.icon,
      products: json.products.isEmpty ? [] : json.products,
      bundles: json.bundles.isEmpty ? [] : json.bundles,
    ));

  }
}
