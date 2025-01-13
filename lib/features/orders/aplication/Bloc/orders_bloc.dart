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
    // Remove the FetchAllOrders event handler
  }

  void _onOrdersLoaded(OrdersLoaded event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadInProgress());
    try {
      final orders = await orderRepository.fetchAllOrders(
          page: event.page, perPage: event.perPage);

      emit(OrdersLoadSuccess(
          orders: Orders(orders: orders.getValue()),
          selectedTab: 'Active',
          page: event.page,
          perPage: event.perPage));
    } catch (e) {
      emit(OrdersLoadFailure(
          error: extractErrorMessage(e.toString()),
          page: event.page,
          perPage: event.perPage));
    }
  }

  void _onOrdersTabChanged(OrdersTabChanged event, Emitter<OrdersState> emit) {
    if (state is OrdersLoadSuccess) {
      final currentState = state as OrdersLoadSuccess;
      emit(OrdersLoadSuccess(
        orders: currentState.orders,
        selectedTab: event.selectedTab,
        page: currentState.page,
        perPage: currentState.perPage,
      ));
    }
  }

  void _onOrderCancelled(
      OrderCancelled event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadInProgress());
    try {
      print("cancelando");
      print(event.orderId);

      await orderRepository.cancelOrder(orderId: event.orderId);

      // Fetch updated orders
      final orders =
          await orderRepository.fetchAllOrders(page: 1, perPage: 100);

      print("daleee brii");
      print(orders.isSuccessful());
      print(orders.getValue());
      emit(OrdersLoadSuccess(
          orders: Orders(orders: orders.getValue()),
          selectedTab: 'Active',
          page: 1,
          perPage: 10));
    } catch (e) {
      print("error en el cancel");
      print(e);
      emit(OrderCancelFailure(error: e.toString()));
    }
  }
}
