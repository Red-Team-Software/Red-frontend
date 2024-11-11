import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {

    on<ClearCart>(_clearCart);
    on<AddProduct>(_addProduct);
    on<RemoveProduct>(_removeProduct);
    on<AddOneQuantityProduct>(_addOneQuantityProduct);
    on<RemoveOneQuantityProduct>(_removeOneQuantityProduct);
  }

  void _clearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartState(products: []));
  }

  void _addProduct(AddProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    if (!newProducts.any((element) => element.id == event.product.id)) {
      newProducts.add(event.product);
    } 

    emit(CartState(products: newProducts));
  }

  void _removeProduct(RemoveProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    newProducts.remove(event.product);

    emit(CartState(products: newProducts));
  }

  void _addOneQuantityProduct(AddOneQuantityProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    final index = newProducts.indexWhere((element) => element.id == event.product.id);
    newProducts[index] = event.product.copyWith(quantity: event.product.quantity + 1);

    emit(CartState(products: newProducts));
  }

  void _removeOneQuantityProduct(RemoveOneQuantityProduct event, Emitter<CartState> emit) {
    final newProducts = List<ProductCart>.from(state.products);
    final index = newProducts.indexWhere((element) => element.id == event.product.id);
    newProducts[index] = event.product.copyWith(quantity: event.product.quantity - 1);

    emit(CartState(products: newProducts));
  }
}
