part of 'stripe_cards_bloc.dart';

sealed class StripeCardsState extends Equatable {
  const StripeCardsState();
  
  @override
  List<Object> get props => [];
}

final class StripeCardsInitial extends StripeCardsState {}
