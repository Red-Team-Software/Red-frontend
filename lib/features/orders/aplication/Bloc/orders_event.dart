import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersLoaded extends OrdersEvent {}

class OrdersTabChanged extends OrdersEvent {
  final String selectedTab;

  const OrdersTabChanged({required this.selectedTab});

  @override
  List<Object> get props => [selectedTab];
}
