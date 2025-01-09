part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class FetchOrderById extends OrderEvent {
  final String orderId;

  const FetchOrderById({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}
