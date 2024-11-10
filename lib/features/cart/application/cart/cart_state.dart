part of 'cart_bloc.dart';

class CartState extends Equatable {
  
  final Cart cart;

  const CartState({
    required this.cart,
  });
  
  double get subtotal {
    double subtotal = 0;
    for (var product in cart.products) {
      subtotal += product.price * product.quantity;
    }

    return subtotal;
  }

  double get total {
    return subtotal - cart.discount;
  }

  int get totalItems {
    return cart.products.length + (cart.bundles?.length ?? 0);
  }

  @override
  List<Object> get props => [ cart ];
}

