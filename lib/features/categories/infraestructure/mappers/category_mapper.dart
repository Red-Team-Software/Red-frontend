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
}
