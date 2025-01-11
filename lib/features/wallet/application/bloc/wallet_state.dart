part of 'wallet_bloc.dart';

class WalletState  {}

class NotPaying extends WalletState {
}

class Paying extends WalletState {
}

class PayingError extends WalletState {
  final String message;

  PayingError(this.message);
}