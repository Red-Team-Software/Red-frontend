part of 'wallet_bloc.dart';

sealed class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class PayPagoMovil extends WalletEvent {
  final double amount;
  final String phone;
  final String reference;
  final String bank;
  final String identification;
  final String paymentId;

  const PayPagoMovil({
    required this.amount,
    required this.phone,
    required this.reference,
    required this.bank,
    required this.identification,
    required this.paymentId,
  });

  @override
  List<Object> get props => [amount, phone, reference, bank, identification, paymentId];
}