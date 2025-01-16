part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  final Order order;
  final double shippingFee;

  const OrderLoaded({required this.order, required this.shippingFee});

  @override
  List<Object?> get props => [order, shippingFee];
}

class OrderLoading extends OrderState {}

class OrderError extends OrderState {
  final String message;

  const OrderError({required this.message});

  @override
  List<Object?> get props => [message];
}
