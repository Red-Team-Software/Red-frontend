import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';
import 'package:GoDeli/features/cart/application/cart/cart_bloc.dart';
import 'package:GoDeli/features/checkout/domain/address.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc cartBloc;

  CheckoutBloc({required this.cartBloc}) : super(const CheckoutState()) {
    on<LoadCheckoutData>(_onLoadCheckoutData);
    on<SelectAddress>(_onSelectAddress);
    on<AddNewAddress>(_onAddNewAddress);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<ProceedToCheckout>(_onProceedToCheckout);
  }

  void _onLoadCheckoutData(
      LoadCheckoutData event, Emitter<CheckoutState> emit) {
    final cartState = cartBloc.state;
    emit(state.copyWith(
      products: cartState.products,
      bundles: cartState.bundles,
      addresses: [
        Address('Home', 'Av Principal de bello campo, edif tupamaro'),
        Address('Office', 'Casita de bryan, al frente del guaire')
      ],
      selectedAddress:
          Address('Home', 'Av Principal de bello campo, edif tupamaro'),
    ));
  }

  void _onSelectAddress(SelectAddress event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(selectedAddress: event.address));
  }

  void _onAddNewAddress(AddNewAddress event, Emitter<CheckoutState> emit) {
    final newAddress = Address(event.title, event.location);
    final updatedAddresses = List<Address>.from(state.addresses)
      ..add(newAddress);
    emit(state.copyWith(
      addresses: updatedAddresses,
      selectedAddress: newAddress,
    ));
  }

  void _onSelectPaymentMethod(
      SelectPaymentMethod event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(selectedPaymentMethod: event.paymentMethod));
  }

  void _onProceedToCheckout(
      ProceedToCheckout event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(isProcessing: true));
    // Agrega lógica de procesamiento del checkout aquí
  }
}
