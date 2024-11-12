import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/cart/infraestructure/repositories/local_storage_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  
  final LocalStorageRepositoryImpl repository;
  
  CartBloc({ required this.repository }) : super(const CartState()) {

    on<ClearCart>(_clearCart);
    on<AddProduct>(_addProduct);
    on<RemoveProduct>(_removeProduct);
    on<AddOneQuantityProduct>(_addOneQuantityProduct);
    on<RemoveOneQuantityProduct>(_removeOneQuantityProduct);
    on<LoadCart>(_loadCart); 

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
    emit(const CartState(products: []));
  }

  void _addProduct(AddProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    if (!newProducts.any((element) => element.product.id == event.product.product.id)) {
      newProducts.add(event.product);
      repository.addProductToCart(event.product);
    } 
    emit(CartState(products: newProducts));
  }

  void _removeProduct(RemoveProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    newProducts.remove(event.product);
    repository.removeProductFromCart(event.product);

    emit(CartState(products: newProducts));
  }

  void _addOneQuantityProduct(AddOneQuantityProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    final index = newProducts.indexWhere((element) => element.product.id == event.product.product.id);
    newProducts[index] = event.product.copyWith(quantity: event.product.quantity + 1);
    repository.updateProductQuantity(event.product.product.id, event.product.quantity + 1);
    emit(CartState(products: newProducts));
  }

  void _removeOneQuantityProduct(RemoveOneQuantityProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    final index = newProducts.indexWhere((element) => element.product.id == event.product.product.id);
    newProducts[index] = event.product.copyWith(quantity: event.product.quantity - 1);
    repository.updateProductQuantity(event.product.product.id, event.product.quantity - 1);


    emit(CartState(products: newProducts));
  }
}
