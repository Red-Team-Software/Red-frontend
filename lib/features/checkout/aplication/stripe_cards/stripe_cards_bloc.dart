import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stripe_cards_event.dart';
part 'stripe_cards_state.dart';

class StripeCardsBloc extends Bloc<StripeCardsEvent, StripeCardsState> {
  StripeCardsBloc() : super(StripeCardsInitial()) {
    on<StripeCardsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
