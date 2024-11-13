import 'package:GoDeli/features/cart/domain/product_cart.dart';

abstract class LocalStorageRepository {
  Future<void> addProductToCart(ProductCart product);
  Future<void> removeProductFromCart(ProductCart product);
  Future<List<ProductCart>> getCartProducts();
  Future<void> updateProductQuantity(String productId, int newQuantity);
  Future<void> clearCart();
}
