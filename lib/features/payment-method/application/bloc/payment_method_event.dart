part of 'payment_method_bloc.dart';

sealed class PaymentMethodEvent extends Equatable {
  const PaymentMethodEvent();

  @override
  List<Object> get props => [];
}

class LoadPaymentMethodEvent extends PaymentMethodEvent {}

class AddFundsPagoMovil extends PaymentMethodEvent {
  final double amount;
  final String phone;
  final String reference;
  final String bank;
  final String id;

  const AddFundsPagoMovil(this.amount, this.phone, this.reference, this.bank, this.id);
}
