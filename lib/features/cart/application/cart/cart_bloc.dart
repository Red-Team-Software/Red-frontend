import 'package:GoDeli/features/cart/domain/cart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

final p1 = Product(
    id: '1',
    name: 'producto1',
    price: 50,
    quantity: 10,
    description:
        'descripcion1descripcion1descripcion1descripcion1descripcion1descripcion1');
final p2 = Product(
    id: '2',
    name: 'producto2',
    price: 100,
    quantity: 5,
    description: 'descripcion1');
final p3 = Product(
    id: '3',
    name: 'producto3',
    price: 20,
    quantity: 20,
    description: 'descripcion1');
final List<Product> products = [p1, p2, p3, p1];

Cart cart = Cart(products: products);

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(cart: cart)) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ClearCart>(_clearCart);
    on<AddProduct>(_addProduct);
    on<RemoveProduct>(_removeProduct);
    on<AddOneQuantityProduct>(_addOneQuantityProduct);
    on<RemoveOneQuantityProduct>(_removeOneQuantityProduct);
  }

  void _clearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartState(cart: Cart(products: [])));
  }

  void _addProduct(AddProduct event, Emitter<CartState> emit) {
    final newProducts = List<Product>.from(state.cart.products);
    newProducts.add(event.product);

    emit(CartState(cart: Cart(products: newProducts)));
  }

  void _removeProduct(RemoveProduct event, Emitter<CartState> emit) {
    final newProducts = List<Product>.from(state.cart.products);
    newProducts.remove(event.product);

    emit(CartState(cart: Cart(products: newProducts)));
  }

  void _addOneQuantityProduct(AddOneQuantityProduct event, Emitter<CartState> emit) {
    final newProducts = List<Product>.from(state.cart.products);
    final index = newProducts.indexWhere((element) => element.id == event.product.id);
    newProducts[index] = event.product.copyWith(quantity: event.product.quantity + 1);

    emit(CartState(cart: Cart(products: newProducts)));
  }

  void _removeOneQuantityProduct(RemoveOneQuantityProduct event, Emitter<CartState> emit) {
    final newProducts = List<Product>.from(state.cart.products);
    final index = newProducts.indexWhere((element) => element.id == event.product.id);
    newProducts[index] = event.product.copyWith(quantity: event.product.quantity - 1);

    emit(CartState(cart: Cart(products: newProducts)));
  }
}
