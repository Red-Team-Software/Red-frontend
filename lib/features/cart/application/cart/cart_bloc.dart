
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/cart/infraestructure/repositories/local_storage_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  
  final LocalStorageRepositoryImpl repository;
  
  CartBloc({ required this.repository }) : super(const CartState()) {

    on<LoadCart>(_loadCart); 
    on<ClearCart>(_clearCart);
    // Products
    on<AddProduct>(_addProduct);
    on<RemoveProduct>(_removeProduct);
    on<AddQuantityProduct>(_addQuantityProduct);
    on<RemoveQuantityProduct>(_removeQuantityProduct);
    // Bundles
    on<AddBundle>(_addBundle);
    on<RemoveBundle>(_removeBundle);
    on<AddQuantityBundle>(_addQuantityBundle);
    on<RemoveQuantityBundle>(_removeQuantityBundle);
    


    add(LoadCart());
  }

  void _loadCart(LoadCart event, Emitter<CartState> emit) async {
  try {
    // Cargar los productos del carrito desde el repositorio
    final cartProducts = await repository.getCartProducts();
    // Emitir el nuevo estado con los productos cargados
    emit(CartState(products: cartProducts));
  } catch (e) {
    emit(const CartState(products: [], errorMessage: "Error al cargar el carrito"));
  }
}


  void _clearCart(ClearCart event, Emitter<CartState> emit) {
    repository.clearCart();
    emit(const CartState(products: [], bundles: []));
  }

  void _addProduct(AddProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    if (!newProducts.any((element) => element.product.id == event.product.product.id)) {
      newProducts.add(event.product);
      repository.addProductToCart(event.product);
    } 
    emit(state.copyWith(products: newProducts));
  }

  void _removeProduct(RemoveProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    newProducts.remove(event.product);
    repository.removeProductFromCart(event.product);

    emit(state.copyWith(products: newProducts));
  }

  void _addQuantityProduct(AddQuantityProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    final index = newProducts.indexWhere((element) => element.product.id == event.product.product.id);
    newProducts[index] = event.product.copyWith(quantity: event.product.quantity +  event.quantity);
    repository.updateProductQuantity(event.product.product.id, event.product.quantity + event.quantity);
    emit(state.copyWith(products: newProducts));
  }

  void _removeQuantityProduct(RemoveQuantityProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    final index = newProducts.indexWhere((element) => element.product.id == event.product.product.id);
    newProducts[index] = event.product.copyWith(quantity: event.product.quantity -  event.quantity);
    repository.updateProductQuantity(event.product.product.id, event.product.quantity -  event.quantity);


    emit(state.copyWith(products: newProducts));
  }

  _addBundle(AddBundle event, Emitter<CartState> emit) {
    final newBundles = List<BundleCart>.from(state.bundles);
    if (!newBundles.any((element) => element.bundle.id == event.bundle.bundle.id)) {
      newBundles.add(event.bundle);
      repository.addBundleToCart(event.bundle);
    }

    emit(state.copyWith(bundles: newBundles));
  }

  _removeBundle(RemoveBundle event, Emitter<CartState> emit) {
    final newBundles = List<BundleCart>.from(state.bundles);
    newBundles.remove(event.bundle);
    repository.removeBundleFromCart(event.bundle);

    emit(state.copyWith(bundles: newBundles));
  }

  _addQuantityBundle(AddQuantityBundle event, Emitter<CartState> emit) {
    final newBundles = List<BundleCart>.from(state.bundles);
    final index = newBundles.indexWhere((element) => element.bundle.id == event.bundle.bundle.id);
    newBundles[index] = event.bundle.copyWith(quantity: event.bundle.quantity +  event.quantity);
    repository.updateBundleQuantity(event.bundle.bundle.id, event.bundle.quantity + event.quantity);

    emit(state.copyWith(bundles: newBundles));
  }
  
  _removeQuantityBundle(RemoveQuantityBundle event, Emitter<CartState> emit) {
    final newBundles = List<BundleCart>.from(state.bundles);
    final index = newBundles.indexWhere((element) => element.bundle.id == event.bundle.bundle.id);
    newBundles[index] = event.bundle.copyWith(quantity: event.bundle.quantity -  event.quantity);
    repository.updateBundleQuantity(event.bundle.bundle.id, event.bundle.quantity - event.quantity);

    emit(state.copyWith(bundles: newBundles));
  }

}
