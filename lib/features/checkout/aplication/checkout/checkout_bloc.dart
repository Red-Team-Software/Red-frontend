import 'package:GoDeli/common/Exception/exception_mapper.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:GoDeli/features/tax-shipping/domain/repositories/tax-shipping_repository.dart';
import 'package:GoDeli/features/user/application/use_cases/add_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/delete_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/get_user_directions_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/update_user_direction_use_case.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/delete_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_direction_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/checkout/domain/address.dart';
import 'package:GoDeli/features/payment-method/domain/repositories/payment-method_repository.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc cartBloc;
  final IOrderRepository orderRepository;
  final void Function(Order order) onOrderCreated;
  final GetUserDirectionsUseCase getUserDirectionsUseCase;
  final AddUserDirectionUseCase addUserDirectionUseCase;
  final DeleteUserDirectionUseCase deleteUserDirectionUseCase;
  final UpdateUserDirectionUseCase updateUserDirectionUseCase;
  final ITaxShippinRepository taxRepository;
  final IPaymentMethodRepository paymentMethodRepository;

  CheckoutBloc(
      {required this.cartBloc,
      required this.orderRepository,
      required this.onOrderCreated,
      required this.getUserDirectionsUseCase,
      required this.addUserDirectionUseCase,
      required this.deleteUserDirectionUseCase,
      required this.updateUserDirectionUseCase,
      required this.taxRepository,
      required this.paymentMethodRepository})
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
    on<ClearErrorEvent>(_onClearError);
  }

  Future<void> _onLoadCheckoutData(
      LoadCheckoutData event, Emitter<CheckoutState> emit) async {
    print("Loading checkout data...");
    final cartState = cartBloc.state;
    emit(state.copyWith(isProcessing: true));
    final resDirections = await getUserDirectionsUseCase.execute(null);

    if (resDirections.isSuccessful()) {
      final directions = resDirections.getValue();

      // Si la lista de direcciones está vacía, asigna un array vacío
      final addresses = directions.isEmpty
          ? <Address>[] // Lista vacía de direcciones
          : directions.map<Address>((direction) {
              // Si necesitas mapear las direcciones a Address, lo harías aquí
              return Address(direction.id, direction.addressName,
                  direction.direction, direction.latitude, direction.longitude);
            }).toList();

      final paymentMethodsResult =
          await paymentMethodRepository.fetchAllPaymentMethods();
      if (paymentMethodsResult.isSuccessful()) {
        final paymentMethods = paymentMethodsResult.getValue();
        emit(state.copyWith(
          paymentMethods: paymentMethods,
          selectedPaymentMethod:
              paymentMethods.isNotEmpty ? paymentMethods.first : null,
        ));
      } else {
        emit(state.copyWith(errorMessage: 'Failed to fetch payment methods.'));
      }

      // Actualiza el estado con las direcciones obtenidas
      emit(state.copyWith(
        products: cartState.products,
        bundles: cartState.bundles,
        addresses: addresses,
        selectedAddress: addresses.isNotEmpty ? addresses.first : null,
        isProcessing: false,
      ));

      final res = await taxRepository.calculateTaxShipping(
          amount: cartState.total,
          currency: "USD",
          address: state.selectedAddress!.location);

      if (res.isSuccessful()) {
        final taxShipping = res.getValue();
        emit(state.copyWith(
          tax: taxShipping.taxes,
          shipping: taxShipping.shipping,
        ));
      } else {
        emit(state.copyWith(
          errorMessage: 'Failed to calculate tax and shipping.',
        ));
      }
    } else {
      // Maneja el error si la respuesta no es exitosa
      emit(state.copyWith(
        errorMessage: 'Failed to fetch addresses.',
        isProcessing: false,
      ));
      print("Failed to fetch addresses.");
    }
  }

  Future<void> _onSelectAddress(
      SelectAddress event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(isProcessing: true));
    final cartState = cartBloc.state;

    final res = await taxRepository.calculateTaxShipping(
        amount: cartState.total,
        currency: "USD",
        address: event.address.location);

    if (res.isSuccessful()) {
      final taxShipping = res.getValue();
      emit(state.copyWith(
        selectedAddress: event.address,
        tax: taxShipping.taxes,
        shipping: taxShipping.shipping,
      ));
    } else {
      emit(state.copyWith(
        errorMessage: 'Failed to calculate tax and shipping.',
      ));
    }
    emit(state.copyWith(isProcessing: false));
  }

  Future _onAddNewAddress(
      AddNewAddress event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(isProcessing: true));
    final res = await addUserDirectionUseCase.execute(AddUserDirectionDto(
      direction: event.location,
      name: event.title,
      favorite: false, // Assuming default value
      lat: event.lat,
      lng: event.lng,
    ));

    if (res.isSuccessful()) {
      final resDirections = await getUserDirectionsUseCase.execute(null);

      if (resDirections.isSuccessful()) {
        final directions = resDirections.getValue();
        final addresses = directions.map<Address>((direction) {
          return Address(direction.id, direction.addressName,
              direction.direction, direction.latitude, direction.longitude);
        }).toList();

        emit(state.copyWith(
          addresses: addresses,
          selectedAddress: addresses.isNotEmpty ? addresses.first : null,
        ));

        final cartState = cartBloc.state;
        final res = await taxRepository.calculateTaxShipping(
            amount: cartState.total,
            currency: "USD",
            address: state.selectedAddress!.location);

        if (res.isSuccessful()) {
          final taxShipping = res.getValue();
          emit(state.copyWith(
            tax: taxShipping.taxes,
            shipping: taxShipping.shipping,
          ));
        } else {
          emit(state.copyWith(
            errorMessage: 'Failed to calculate tax and shipping.',
          ));
        }
      } else {
        emit(state.copyWith(
          errorMessage: 'Failed to fetch addresses.',
        ));
      }
    }

    emit(state.copyWith(isProcessing: false));
  }

  void _onSelectPaymentMethod(
      SelectPaymentMethod event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(selectedPaymentMethod: event.paymentMethod));
    print("Selected payment method: ${state.selectedPaymentMethod?.name}");
  }

  void _onProceedToCheckout(
      ProceedToCheckout event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(isProcessing: true));
  }

  Future<void> _onProcessPayment(
      ProcessPayment event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(isProcessing: true));

    print("Procesando pago...");
    print("selectedPaymentMethod: ${event.paymentMethod}");
    print("stripePaymentMethod: ${event.stripePaymentMethod}");

    final result = await orderRepository.processPayment(
      paymentMethod: event.paymentMethod,
      stripePaymentMethod: event.stripePaymentMethod,
      idUserDirection: event.address,
      bundles: event.bundles,
      products: event.products,
    );

    if (result.isSuccessful()) {
      final order = result.getValue();
      emit(state.copyWith(isProcessing: false));
      onOrderCreated(order);
    } else {
      emit(state.copyWith(
          isProcessing: false,
          errorMessage: extractErrorMessage(result.getError().toString())));
    }
  }

  void _onFetchAddresses(
      FetchAddressesEvent event, Emitter<CheckoutState> emit) async {
    // final resDirections = await getUserDirectionsUseCase.execute(null);

    // print("res de get directions");
    // print(resDirections);
  }

  void _onRemoveAddress(
      RemoveAddressEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(isProcessing: true));
    final res = await deleteUserDirectionUseCase.execute(DeleteUserDirectionDto(
      id: event.address.id,
    ));

    if (res.isSuccessful()) {
      final resDirections = await getUserDirectionsUseCase.execute(null);

      if (resDirections.isSuccessful()) {
        final directions = resDirections.getValue();
        final addresses = directions.map<Address>((direction) {
          return Address(direction.id, direction.addressName,
              direction.direction, direction.latitude, direction.longitude);
        }).toList();

        emit(state.copyWith(
          addresses: addresses,
          selectedAddress: addresses.isNotEmpty ? addresses.first : null,
          tax: addresses.isEmpty ? 0 : state.tax,
          shipping: addresses.isEmpty ? 0 : state.shipping,
        ));
      } else {
        emit(state.copyWith(
          errorMessage: 'Failed to fetch addresses.',
        ));
      }
    }
    emit(state.copyWith(isProcessing: false));
  }

  void _onUpdateAddress(
      UpdateAddressEvent event, Emitter<CheckoutState> emit) async {
    // Update address in the database
    // emit(CheckoutState with updated addresses);
  }

  void _onClearError(ClearErrorEvent event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(errorMessage: ''));
  }
}
