// Convierte Product (Dominio) a ProductEntity (Infraestructura)
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/infraestructure/models/product_entity.dart';

class ProductEntityMapper {
  static mapProductToEntity(Product product) {
    return ProductEntity(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      currency: product.currency,
      expirationDate: product.expirationDate,
      weigth: product.weigth?.toInt(),
      measurement: product.measurement,
    );
  }

  // Convierte ProductEntity (Infraestructura) a Product (Dominio)
  static Product mapProductToDomain(ProductEntity entity) {
    return Product(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
      currency: entity.currency,
      expirationDate: entity.expirationDate,
      weigth: entity.weigth?.toDouble(),
      measurement: entity.measurement,
    );
  }
}
