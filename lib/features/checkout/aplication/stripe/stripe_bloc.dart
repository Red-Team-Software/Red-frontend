import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stripe_event.dart';
part 'stripe_state.dart';

class StripeBloc extends Bloc<StripeEvent, StripeState> {
  StripeBloc() : super(StripeInitial()) {
    on<StripeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
