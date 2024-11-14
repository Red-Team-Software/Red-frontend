import 'package:equatable/equatable.dart';
import 'package:GoDeli/features/checkout/domain/address.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class LoadCheckoutData extends CheckoutEvent {}

class SelectAddress extends CheckoutEvent {
  final Address address;
  const SelectAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class AddNewAddress extends CheckoutEvent {
  final String title;
  final String location;
  const AddNewAddress(this.title, this.location);

  @override
  List<Object?> get props => [title, location];
}

class SelectPaymentMethod extends CheckoutEvent {
  final String paymentMethod;
  const SelectPaymentMethod(this.paymentMethod);

  @override
  List<Object?> get props => [paymentMethod];
}

class ProceedToCheckout extends CheckoutEvent {}
