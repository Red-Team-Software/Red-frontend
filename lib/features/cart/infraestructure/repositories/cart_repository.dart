import 'package:GoDeli/features/cart/domain/repositories/cart_repositories.dart';
import 'package:GoDeli/features/products/domain/product.dart';

class CartRepository extends ICartRepository {
  //! Aqui iria el manejador de local storage
  final localStorageManager;

  CartRepository(this.localStorageManager);

  @override
  Future<void> addProductToCart(Product product) {
    // TODO: implement addProductToCart
    throw UnimplementedError();
  }

  @override
  Future<void> clearCart() {
    // TODO: implement clearCart
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getCartProducts() {
    // TODO: implement getCartProducts
    throw UnimplementedError();
  }

  @override
  Future<void> removeProductFromCart(Product product) {
    // TODO: implement removeProductFromCart
    throw UnimplementedError();
  }
}
