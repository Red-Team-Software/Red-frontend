import 'package:GoDeli/features/products/domain/product.dart';

import '../models/product_response.dart';

class ProductMapper {
  static Product productToDomian(ProductResponse json) {
    return Product(
      id: json.id,
      name: json.name,
      description: json.description,
      price: json.price,
      currency: json.currency,
      imageUrl: json.images,
    );
  }
}
