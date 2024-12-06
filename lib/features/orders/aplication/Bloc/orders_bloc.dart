import 'dart:math';

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
    // Remove the FetchAllOrders event handler
  }

  void _onOrdersLoaded(OrdersLoaded event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadInProgress());
    try {
      final orders = await orderRepository.fetchAllOrders(
          page: event.page, perPage: event.perPage);

      print("daleee brii");
      print(orders.isSuccessful());

      print(orders.getValue());

      emit(OrdersLoadSuccess(
          orders: Orders(orders: orders.getValue()),
          selectedTab: 'Active',
          page: event.page,
          perPage: event.perPage));
    } catch (e) {
      emit(OrdersLoadFailure(
          error: e.toString(), page: event.page, perPage: event.perPage));
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
}
