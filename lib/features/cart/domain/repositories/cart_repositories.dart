import 'package:GoDeli/features/products/domain/product.dart';

abstract class ICartRepository {
  Future<void> addProductToCart(Product product);
  Future<void> removeProductFromCart(Product product);
  Future<List<Product>> getCartProducts();
  Future<void> clearCart();
}