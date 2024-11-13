import 'package:GoDeli/features/cart/domain/datasource/local_storage_datasource.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/cart/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  //! Aqui iria el manejador de local storage
  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl({required this.dataSource});

  @override
  Future<void> addProductToCart(ProductCart product) {
    return dataSource.addProductToCart(product);
  }

  @override
  Future<void> clearCart() {
    return dataSource.clearCart();
  }

  @override
  Future<List<ProductCart>> getCartProducts() {
    return dataSource.getCartProducts();
  }

  @override
  Future<void> removeProductFromCart(ProductCart product) {
    return dataSource.removeProductFromCart(product);
  }
  
  @override
  Future<void> updateProductQuantity(String productId, int newQuantity) {
    return dataSource.updateProductQuantity(productId, newQuantity);
  }
}
