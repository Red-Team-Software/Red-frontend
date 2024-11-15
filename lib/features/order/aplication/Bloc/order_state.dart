part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  final Order order;

  const OrderLoaded({required this.order});

  @override
  List<Object?> get props => [order];
}
