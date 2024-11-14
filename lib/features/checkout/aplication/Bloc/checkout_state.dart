import 'package:equatable/equatable.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/checkout/domain/address.dart';

class CheckoutState extends Equatable {
  final List<ProductCart> products;
  final List<BundleCart> bundles;
  final List<Address> addresses;
  final Address? selectedAddress;
  final String selectedPaymentMethod;
  final bool isProcessing;
  final String errorMessage;

  const CheckoutState({
    this.products = const [],
    this.bundles = const [],
    this.addresses = const [],
    this.selectedAddress,
    this.selectedPaymentMethod = '',
    this.isProcessing = false,
    this.errorMessage = '',
  });

  // Nuevo getter para calcular el total de items en el carrito
  int get cartItemsCount => products.length + bundles.length;

  CheckoutState copyWith({
    List<ProductCart>? products,
    List<BundleCart>? bundles,
    List<Address>? addresses,
    Address? selectedAddress,
    String? selectedPaymentMethod,
    bool? isProcessing,
    String? errorMessage,
  }) {
    return CheckoutState(
      products: products ?? this.products,
      bundles: bundles ?? this.bundles,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isProcessing: isProcessing ?? this.isProcessing,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        products,
        bundles,
        addresses,
        selectedAddress,
        selectedPaymentMethod,
        isProcessing,
        errorMessage,
      ];
}
