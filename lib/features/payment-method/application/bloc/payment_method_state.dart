part of 'payment_method_bloc.dart';

class PaymentMethodState{}

final class PaymentMethodLoaded extends PaymentMethodState {
  final List<PaymentMethod> paymentMethods;

  PaymentMethodLoaded(this.paymentMethods);

}

final class PaymentMethodLoading extends PaymentMethodState {}

final class PaymentMethodError extends PaymentMethodState {
  final String message;

  PaymentMethodError(this.message);
}

final class Paying extends PaymentMethodState {}