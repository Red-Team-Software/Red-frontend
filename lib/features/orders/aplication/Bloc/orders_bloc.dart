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
            "orderPayment": {
              "paymetAmount": 61.27,
              "paymentCurrency": "usd",
              "payementMethod": "card"
            },
            "orderDirection": {"lat": 10.4399, "long": -66.89275},
            "products": [
              {
                "id": "1",
                "nombre": "Coca-Cola",
                "descripcion": "Soda",
                "price": 1.5,
                "images": ["image1.jpg"],
                "currency": "usd",
                "quantity": 2
              },
              {
                "id": "2",
                "nombre": "Pepsi",
                "descripcion": "Soda",
                "price": 1.5,
                "images": ["image2.jpg"],
                "currency": "usd",
                "quantity": 1
              }
            ],
            "bundles": [
              {
                "id": "1",
                "nombre": "Bundle 1",
                "descripcion": "Bundle description",
                "price": 10.0,
                "currency": "usd",
                "images": ["bundle1.jpg"],
                "quantity": 1
              }
            ]
          },
          {
            "orderId": "0dbd42dc-0bed-446b-ac90-68e60fc43a96",
            "orderState": "delivered",
            "orderCreatedDate": "2024-12-05",
            "totalAmount": 25.99,
            "orderPayment": {
              "paymetAmount": 25.99,
              "paymentCurrency": "usd",
              "payementMethod": "card"
            },
            "orderDirection": {"lat": 10.4399, "long": -66.89275},
            "products": [
              {
                "id": "3",
                "nombre": "Burger",
                "descripcion": "Food",
                "price": 5.0,
                "images": ["burger.jpg"],
                "currency": "usd",
                "quantity": 2
              }
            ],
            "bundles": []
          },
          {
            "orderId": "279ebb28-9344-4234-9690-8d82057a547f",
            "orderState": "cancelled",
            "orderCreatedDate": "2024-12-04",
            "totalAmount": 12.50,
            "orderPayment": {
              "paymetAmount": 12.50,
              "paymentCurrency": "usd",
              "payementMethod": "card"
            },
            "orderDirection": {"lat": 10.4399, "long": -66.89275},
            "products": [],
            "bundles": [
              {
                "id": "2",
                "nombre": "Combo 1",
                "descripcion": "Combo description",
                "price": 6.0,
                "currency": "usd",
                "images": ["combo1.jpg"],
                "quantity": 2
              },
              {
                "id": "3",
                "nombre": "Combo 2",
                "descripcion": "Combo description",
                "price": 6.5,
                "currency": "usd",
                "images": ["combo2.jpg"],
                "quantity": 1
              }
            ]
          },
          {
            "orderId": "8739a4a6-fd5c-4a66-9768-297193c1555d",
            "orderState": "canceled",
            "orderCreatedDate": "2024-12-06",
            "totalAmount": 15.8,
            "orderPayment": {
              "paymetAmount": 15.8,
              "paymentCurrency": "usd",
              "payementMethod": "card"
            },
            "orderDirection": {"lat": 10.4399, "long": -66.89275},
            "products": [
              {
                "id": "4",
                "nombre": "Cachito de jamon de sousa",
                "descripcion": "Food",
                "price": 3.0,
                "images": ["cachito.jpg"],
                "currency": "usd",
                "quantity": 5
              }
            ],
            "bundles": []
          }
        ]
      });
      emit(OrdersLoadSuccess(orders: orders, selectedTab: 'Active'));
    } catch (e) {
      print("jijija");
      print(e);
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
