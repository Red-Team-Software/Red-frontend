import 'package:GoDeli/common/Exception/exception_mapper.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final IOrderRepository orderRepository;

  OrdersBloc({required this.orderRepository}) : super(OrdersInitial()) {
    on<OrdersLoaded>(_onOrdersLoaded);
    on<OrdersTabChanged>(_onOrdersTabChanged);
    on<OrderCancelled>(_onOrderCancelled);
    on<OrderReported>(_onOrderReported);
    on<ClearOrderReportErrorEvent>(_onClearOrderReportError);
  }

  void _onOrdersLoaded(OrdersLoaded event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadInProgress());
    try {
      final activeOrdersResult = await orderRepository.fetchActiveOrders();
      final pastOrdersResult = await orderRepository.fetchPastOrders();

      if (activeOrdersResult.isSuccessful() &&
          pastOrdersResult.isSuccessful()) {
        emit(OrdersLoadSuccess(
          activeOrders: Orders(orders: activeOrdersResult.getValue()),
          pastOrders: Orders(orders: pastOrdersResult.getValue()),
          selectedTab: 'Active',
        ));
      } else {
        emit(const OrdersLoadFailure(
          error: 'Failed to load orders',
        ));
      }
    } catch (e) {
      emit(OrdersLoadFailure(
        error: extractErrorMessage(e.toString()),
      ));
    }
  }

  void _onOrdersTabChanged(OrdersTabChanged event, Emitter<OrdersState> emit) {
    if (state is OrdersLoadSuccess) {
      final currentState = state as OrdersLoadSuccess;
      emit(OrdersLoadSuccess(
        activeOrders: currentState.activeOrders,
        pastOrders: currentState.pastOrders,
        selectedTab: event.selectedTab,
      ));
    }
  }

  void _onOrderCancelled(
      OrderCancelled event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadInProgress());
    try {
      print(event.orderId);

      await orderRepository.cancelOrder(orderId: event.orderId);

      // Fetch updated orders
      final activeOrdersResult = await orderRepository.fetchActiveOrders();
      final pastOrdersResult = await orderRepository.fetchPastOrders();

      if (activeOrdersResult.isSuccessful() &&
          pastOrdersResult.isSuccessful()) {
        emit(OrdersLoadSuccess(
          activeOrders: Orders(orders: activeOrdersResult.getValue()),
          pastOrders: Orders(orders: pastOrdersResult.getValue()),
          selectedTab: 'Active',
        ));
      } else {
        emit(const OrdersLoadFailure(
          error: 'Failed to load orders',
        ));
      }
    } catch (e) {
      print("error en el cancel");
      print(e);
      emit(OrderCancelFailure(error: e.toString()));
    }
  }

  void _onOrderReported(OrderReported event, Emitter<OrdersState> emit) async {
    OrdersState currentState = state;
    emit(OrdersLoadInProgress());
    try {
      await orderRepository.reportOrder(
          orderId: event.orderId, description: event.description);
    } catch (e) {
      if (currentState is OrdersLoadSuccess) {
        emit(currentState.copyWith(
            orderReportError: extractErrorMessage(e.toString())));
      }
    } finally {
      final activeOrdersResult = await orderRepository.fetchActiveOrders();
      final pastOrdersResult = await orderRepository.fetchPastOrders();

      if (activeOrdersResult.isSuccessful() &&
          pastOrdersResult.isSuccessful()) {
        emit(OrdersLoadSuccess(
          activeOrders: Orders(orders: activeOrdersResult.getValue()),
          pastOrders: Orders(orders: pastOrdersResult.getValue()),
          selectedTab: 'Active',
          orderReportError: null,
        ));
      } else {
        emit(const OrdersLoadFailure(
          error: 'Failed to load orders',
        ));
      }
    }
  }

  void _onClearOrderReportError(
      ClearOrderReportErrorEvent event, Emitter<OrdersState> emit) {
    if (state is OrdersLoadSuccess) {
      emit((state as OrdersLoadSuccess).copyWith(orderReportError: null));
    }
  }
}
