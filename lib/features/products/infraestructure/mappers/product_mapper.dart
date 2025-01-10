import 'package:GoDeli/features/products/domain/product.dart';

import '../models/product_response.dart';

class ProductMapper {
  static Product productToDomain(ProductResponse json) {
    return Product(
      id: json.id,
      name: json.name,
      description: json.description,
      price: json.price,
      currency: json.currency,
      imageUrl: json.images,
      expirationDate: json.caducityDate,
      weigth: json.weigth,
      measurement: json.measurement,
      inStock: json.stock,
      promotions: json.promotion,
      categories: json.categories
    );
  }

  static List<Product> productListToDomain(List<ProductResponse> responses) {
    return responses.map((response) => productToDomain(response)).toList();
  }
}
