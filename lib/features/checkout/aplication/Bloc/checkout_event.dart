import 'package:equatable/equatable.dart';
import 'package:GoDeli/features/checkout/domain/address.dart';
import 'package:flutter/material.dart';

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
  final num lat;
  final num lng;
  const AddNewAddress(this.title, this.location, this.lat, this.lng);

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

class ProcessPayment extends CheckoutEvent {
  final double amount;
  final String currency;
  final String paymentMethod;
  final String stripePaymentMethod;
  final String address;
  final List<Map<String, dynamic>> bundles;
  final List<Map<String, dynamic>> products;
  final BuildContext context;

  const ProcessPayment({
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.stripePaymentMethod,
    required this.address,
    required this.bundles,
    required this.products,
    required this.context,
  });

  @override
  List<Object?> get props => [
        amount,
        currency,
        paymentMethod,
        stripePaymentMethod,
        address,
        bundles,
        products
      ];
}

class FetchAddressesEvent extends CheckoutEvent {}

class RemoveAddressEvent extends CheckoutEvent {
  final Address address;

  const RemoveAddressEvent(this.address);
}

class UpdateAddressEvent extends CheckoutEvent {
  final Address address;

  const UpdateAddressEvent(this.address);
}
