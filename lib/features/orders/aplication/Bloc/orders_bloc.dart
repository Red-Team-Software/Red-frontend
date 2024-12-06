import 'package:bloc/bloc.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  // final OrdersRepository ordersRepository;

  OrdersBloc() : super(OrdersInitial()) {
    on<OrdersLoaded>(_onOrdersLoaded);
    on<OrdersTabChanged>(_onOrdersTabChanged);
  }

  void _onOrdersLoaded(OrdersLoaded event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadInProgress());
    try {
      // final orders = await ordersRepository.fetchOrders();
      // Simulate fetching orders
      final orders = Orders.fromJson({
        "orders": [
          {
            "orderId": "09268406-3bd0-4905-9fba-e26a1c695a6b",
            "orderState": "ongoing",
            "orderCreatedDate": "2024-12-06",
            "totalAmount": 61.27,
            "products": [
              {"name": "Coca-Cola", "quantity": 2},
              {"name": "Pepsi", "quantity": 1}
            ],
            "bundles": [
              {"name": "Bundle 1", "quantity": 1}
            ]
          },
          {
            "orderId": "0dbd42dc-0bed-446b-ac90-68e60fc43a96",
            "orderState": "delivered",
            "orderCreatedDate": "2024-12-05",
            "totalAmount": 25.99,
            "products": [
              {"name": "Burger", "quantity": 2},
            ],
            "bundles": []
          },
          {
            "orderId": "279ebb28-9344-4234-9690-8d82057a547f",
            "orderState": "cancelled",
            "orderCreatedDate": "2024-12-04",
            "totalAmount": 12.50,
            "products": [],
            "bundles": [
              {"name": "Combo 1", "quantity": 2},
              {"name": "Combo 2", "quantity": 1}
            ]
          },
        ]
      });
      emit(OrdersLoadSuccess(orders: orders, selectedTab: 'Active'));
    } catch (e) {
      emit(OrdersLoadFailure(error: e.toString()));
    }
  }

  void _onOrdersTabChanged(OrdersTabChanged event, Emitter<OrdersState> emit) {
    if (state is OrdersLoadSuccess) {
      final currentState = state as OrdersLoadSuccess;
      emit(OrdersLoadSuccess(
        orders: currentState.orders,
        selectedTab: event.selectedTab,
      ));
    }
  }
}
