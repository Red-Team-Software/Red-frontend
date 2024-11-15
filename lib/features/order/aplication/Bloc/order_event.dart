part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrder extends OrderEvent {
  final Order order;

  const LoadOrder({required this.order});

  @override
  List<Object?> get props => [order];
}
