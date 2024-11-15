import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/cart/infraestructure/models/product_cart_entity.dart';
import 'package:GoDeli/features/products/infraestructure/mappers/product_entity_mapper.dart';

class ProductCartEntityMapper {
  // Convierte ProductCart (Dominio) a ProductCartEntity (Infraestructura)
  ProductCartEntity mapProductCartToEntity(ProductCart productCart) {
    final productCartEntity = ProductCartEntity(
      quantity: productCart.quantity,
    );

    // Asigna el enlace de producto
    productCartEntity.product.value =
        ProductEntityMapper.mapProductToEntity(productCart.product);

    return productCartEntity;
  }

// Convierte ProductCartEntity (Infraestructura) a ProductCart (Dominio)
  ProductCart mapProductCartToDomain(ProductCartEntity entity) {
    return ProductCart(
      product: ProductEntityMapper.mapProductToDomain(
          entity.product.value!), // Asume que el enlace ha sido cargado
      quantity: entity.quantity,
    );
  }
}
