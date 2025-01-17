import 'package:equatable/equatable.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoadInProgress extends OrdersState {}

class OrdersLoadSuccess extends OrdersState {
  final Orders activeOrders;
  final Orders pastOrders;
  final String selectedTab;
  final String? orderReportError; // New variable

  const OrdersLoadSuccess({
    required this.activeOrders,
    required this.pastOrders,
    required this.selectedTab,
    this.orderReportError, // Initialize new variable
  });

  @override
  List<Object> get props => [
        activeOrders,
        pastOrders,
        selectedTab,
        orderReportError ?? ''
      ]; // Update props

  OrdersLoadSuccess copyWith({
    Orders? activeOrders,
    Orders? pastOrders,
    String? selectedTab,
    String? orderReportError,
  }) {
    return OrdersLoadSuccess(
      activeOrders: activeOrders ?? this.activeOrders,
      pastOrders: pastOrders ?? this.pastOrders,
      selectedTab: selectedTab ?? this.selectedTab,
      orderReportError: orderReportError ?? this.orderReportError,
    );
  }
}

class OrdersLoadFailure extends OrdersState {
  final String error;

  const OrdersLoadFailure({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}

class OrderCancelSuccess extends OrdersState {}

class OrderCancelFailure extends OrdersState {
  final String error;

  const OrderCancelFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class OrderReportSuccess extends OrdersState {}

class OrderReportFailure extends OrdersState {
  final String error;

  const OrderReportFailure({required this.error});

  @override
  List<Object> get props => [error];
}
