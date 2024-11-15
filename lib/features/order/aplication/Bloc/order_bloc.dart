import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:GoDeli/features/order/domain/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<LoadOrder>(_onLoadOrder);
  }

  void _onLoadOrder(LoadOrder event, Emitter<OrderState> emit) {
    emit(OrderLoaded(order: event.order));
  }
}
