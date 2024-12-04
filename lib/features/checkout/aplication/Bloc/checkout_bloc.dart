import 'package:GoDeli/features/order/aplication/Bloc/order_bloc.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/checkout/domain/address.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc cartBloc;
  final IOrderRepository orderRepository;
  final void Function(Order order) onOrderCreated;

  CheckoutBloc(
      {required this.cartBloc,
      required this.orderRepository,
      required this.onOrderCreated})
      : super(const CheckoutState()) {
    on<LoadCheckoutData>(_onLoadCheckoutData);
    on<SelectAddress>(_onSelectAddress);
    on<AddNewAddress>(_onAddNewAddress);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<ProceedToCheckout>(_onProceedToCheckout);
    on<ProcessPayment>(
        _onProcessPayment); // Agregar el evento de procesamiento de pago
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
  }

  Future<void> _onProcessPayment(
      ProcessPayment event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(isProcessing: true));
    final result = await orderRepository.processPayment(
      amount: event.amount,
      currency: event.currency,
      paymentMethod: event.paymentMethod,
      stripePaymentMethod: event.stripePaymentMethod,
      address: event.address,
      bundles: event.bundles,
      products: event.products,
    );

    if (result.isSuccessful()) {
      final order = result.getValue();
      emit(state.copyWith(isProcessing: false));
      onOrderCreated(order);
    } else {
      emit(
          state.copyWith(isProcessing: false, errorMessage: 'Payment failed.'));
    }
  }
}
