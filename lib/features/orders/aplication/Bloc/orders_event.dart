import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersLoaded extends OrdersEvent {
  const OrdersLoaded();

  @override
  List<Object> get props => [];
}

class OrdersTabChanged extends OrdersEvent {
  final String selectedTab;

  const OrdersTabChanged({required this.selectedTab});

  @override
  List<Object> get props => [selectedTab];
}

class FetchAllOrders extends OrdersEvent {
  const FetchAllOrders();
}

class OrderCancelled extends OrdersEvent {
  final String orderId;

  const OrderCancelled({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class OrderReported extends OrdersEvent {
  final String orderId;
  final String description;

  const OrderReported({required this.orderId, required this.description});

  @override
  List<Object> get props => [orderId, description];
}

class ClearOrderReportErrorEvent extends OrdersEvent {}
