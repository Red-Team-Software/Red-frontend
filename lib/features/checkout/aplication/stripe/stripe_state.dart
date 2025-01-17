part of 'stripe_bloc.dart';

sealed class StripeState extends Equatable {
  const StripeState();
  
  @override
  List<Object> get props => [];
}

final class StripeInitial extends StripeState {}
