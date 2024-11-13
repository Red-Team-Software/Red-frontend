
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';

abstract class LocalStorageDataSource {
  
  Future<List<ProductCart>> getCartProducts();
  Future<List<BundleCart>> getCartBundles();
  Future<void> clearCart();
  // Products 
  Future<void> addProductToCart(ProductCart product);
  Future<void> removeProductFromCart(ProductCart product);
  Future<void> updateProductQuantity(String productId, int newQuantity);

  Future<void> addBundleToCart(BundleCart bundle);
  Future<void> removeBundleFromCart(BundleCart bundle);
  Future<void> updateBundleQuantity(String bundleId, int newQuantity);
}