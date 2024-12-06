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

  const OrdersLoadSuccess({required this.orders, required this.selectedTab});

  @override
  List<Object> get props => [orders, selectedTab];
}

class OrdersLoadFailure extends OrdersState {
  final String error;

  const OrdersLoadFailure({required this.error});

  @override
  List<Object> get props => [error];
}
