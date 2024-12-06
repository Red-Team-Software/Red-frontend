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
  final Orders orders;
  final String selectedTab;
  final int page;
  final int perPage;

  const OrdersLoadSuccess({
    required this.orders,
    required this.selectedTab,
    required this.page,
    required this.perPage,
  });

  @override
  List<Object> get props => [orders, selectedTab, page, perPage];
}

class OrdersLoadFailure extends OrdersState {
  final String error;
  final int page;
  final int perPage;

  const OrdersLoadFailure({
    required this.error,
    required this.page,
    required this.perPage,
  });

  @override
  List<Object> get props => [error, page, perPage];
}

class OrderCancelSuccess extends OrdersState {}

class OrderCancelFailure extends OrdersState {
  final String error;

  const OrderCancelFailure({required this.error});

  @override
  List<Object> get props => [error];
}
