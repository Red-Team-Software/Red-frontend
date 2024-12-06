part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<ProductCart> products;
  final List<BundleCart> bundles;
  final double discount = 0.0;
  final double shipping;
  final double tax;
  final String? errorMessage;

  const CartState({
    this.products = const [],
    this.bundles = const [],
    this.shipping = 0.0,
    this.tax = 0.0,
    this.errorMessage,
  });

  double get subtotal {
    double subtotal = 0;
    for (var product in products) {
      subtotal += product.product.price * product.quantity;
    }

    for (var bundle in bundles) {
      subtotal += bundle.bundle.price * bundle.quantity;
    }

    return subtotal;
  }

  double get total {
    return subtotal - discount;
  }

  int get totalItems {
    return products.length + bundles.length;
  }

  int get totalProducts {
    return products.length;
  }

  int get totalBundles {
    return bundles.length;
  }

  CartState copyWith({
    List<ProductCart>? products,
    List<BundleCart>? bundles,
    double? shipping,
    double? tax,
  }) {
    return CartState(
      products: products ?? this.products,
      bundles: bundles ?? this.bundles,
      shipping: shipping ?? this.shipping,
      tax: tax ?? this.tax,
    );
  }

  @override
  List<Object> get props => [products, bundles, shipping, tax];
}
