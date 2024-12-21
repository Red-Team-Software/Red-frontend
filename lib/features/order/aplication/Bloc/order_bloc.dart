import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<FetchOrderById>(_onFetchOrderById);
  }

  Future<void> _onFetchOrderById(
      FetchOrderById event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    final result = await orderRepository.fetchOrderById(orderId: event.orderId);
    if (result.isSuccessful()) {
      emit(OrderLoaded(order: result.getValue()));
    } else {
      emit(const OrderError(message: 'Failed to load order'));
    }
  }
}
