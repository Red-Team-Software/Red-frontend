import 'package:GoDeli/features/order/aplication/Bloc/order_bloc.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:GoDeli/features/user/application/use_cases/add_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/delete_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/get_user_directions_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/update_user_direction_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/checkout/domain/address.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc cartBloc;
  final IOrderRepository orderRepository;
  final void Function(Order order) onOrderCreated;
  final GetUserDirectionsUseCase getUserDirectionsUseCase;
  final AddUserDirectionUseCase addUserDirectionUseCase;
  final DeleteUserDirectionUseCase deleteUserDirectionUseCase;
  final UpdateUserDirectionUseCase updateUserDirectionUseCase;

  CheckoutBloc(
      {required this.cartBloc,
      required this.orderRepository,
      required this.onOrderCreated,
      required this.getUserDirectionsUseCase,
      required this.addUserDirectionUseCase,
      required this.deleteUserDirectionUseCase,
      required this.updateUserDirectionUseCase})
      : super(const CheckoutState()) {
    on<LoadCheckoutData>(_onLoadCheckoutData);
    on<SelectAddress>(_onSelectAddress);
    on<AddNewAddress>(_onAddNewAddress);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<ProceedToCheckout>(_onProceedToCheckout);
    on<ProcessPayment>(_onProcessPayment);
    on<FetchAddressesEvent>(_onFetchAddresses);
    on<RemoveAddressEvent>(_onRemoveAddress);
    on<UpdateAddressEvent>(_onUpdateAddress);
  }

  Future<void> _onLoadCheckoutData(
      LoadCheckoutData event, Emitter<CheckoutState> emit) async {
    final cartState = cartBloc.state;

    final resDirections = await getUserDirectionsUseCase.execute(null);

    print("resDirections");
    print(resDirections);

    if (resDirections.isSuccessful()) {
      final directions = resDirections.getValue();

      // Si la lista de direcciones está vacía, asigna un array vacío
      final addresses = directions.isEmpty
          ? <Address>[] // Lista vacía de direcciones
          : directions.map<Address>((direction) {
              // Si necesitas mapear las direcciones a Address, lo harías aquí
              return Address(direction.addressName, direction.address);
            }).toList();

      // Actualiza el estado con las direcciones obtenidas
      emit(state.copyWith(
        addresses: addresses,
        selectedAddress: addresses.isNotEmpty ? addresses.first : null,
      ));
    } else {
      // Maneja el error si la respuesta no es exitosa
      emit(state.copyWith(
        errorMessage: 'Failed to fetch addresses.',
      ));
    }
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

  void _onFetchAddresses(
      FetchAddressesEvent event, Emitter<CheckoutState> emit) async {
    final resDirections = await getUserDirectionsUseCase.execute(null);

    print("res de get directions");
    print(resDirections);
  }

  void _onRemoveAddress(
      RemoveAddressEvent event, Emitter<CheckoutState> emit) async {
    // Remove address from the database
    // emit(CheckoutState with updated addresses);
  }

  void _onUpdateAddress(
      UpdateAddressEvent event, Emitter<CheckoutState> emit) async {
    // Update address in the database
    // emit(CheckoutState with updated addresses);
  }
}
