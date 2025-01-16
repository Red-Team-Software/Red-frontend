import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersLoaded extends OrdersEvent {
  final int page;
  final int perPage;

  const OrdersLoaded({this.page = 1, this.perPage = 10});

  @override
  List<Object> get props => [page, perPage];
}

class OrdersTabChanged extends OrdersEvent {
  final String selectedTab;

  const OrdersTabChanged({required this.selectedTab});

  @override
  List<Object> get props => [selectedTab];
}

class FetchAllOrders extends OrdersEvent {
  final int page;
  final int perPage;

  const FetchAllOrders({this.page = 1, this.perPage = 100});
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
