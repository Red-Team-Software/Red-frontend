import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<FetchOrderById>(_onFetchOrderById);
    on<ClearOrderState>(_onClearOrderState);
  }

  Future<void> _onFetchOrderById(
      FetchOrderById event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    final result = await orderRepository.fetchOrderById(orderId: event.orderId);
    if (result.isSuccessful()) {
      final order = result.getValue();
      final double productTotal = order.products
          .fold(0, (sum, item) => sum + item.product.price * item.quantity);
      final double bundleTotal = order.bundles
          .fold(0, (sum, item) => sum + item.bundle.price * item.quantity);
      final double shippingFee =
          order.totalAmount - (productTotal + bundleTotal);

      // Check if the order has a courier
      if (order.orderCourier != null) {
        final courierResult =
            await orderRepository.fetchCourierPosition(orderId: order.id);
        if (courierResult.isSuccessful()) {
          final courierPosition = courierResult.getValue();
          // Update the order's courier location

          print("la posicion del courier");
          print(courierPosition);
          order.orderCourier!.location = courierPosition;
        } else {
          emit(const OrderError(message: 'Failed to fetch courier position'));
          return;
        }
      }

      emit(OrderLoaded(order: order, shippingFee: shippingFee));
    } else {
      emit(const OrderError(message: 'Failed to load order'));
    }
  }

  void _onClearOrderState(ClearOrderState event, Emitter<OrderState> emit) {
    emit(OrderInitial());
  }
}
