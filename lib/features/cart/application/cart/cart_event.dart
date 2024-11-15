part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class ClearCart extends CartEvent {}

class AddProduct extends CartEvent {
  final ProductCart product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProduct extends CartEvent {
  final ProductCart product;

  const RemoveProduct(this.product);

  @override
  List<Object> get props => [product];
}

class AddQuantityProduct extends CartEvent {
  final ProductCart product;
  final int quantity;
  const AddQuantityProduct(this.product, this.quantity);

  @override
  List<Object> get props => [product];
}

class RemoveQuantityProduct extends CartEvent {
  final ProductCart product;

  final int quantity;

  const RemoveQuantityProduct(this.product, this.quantity);

  @override
  List<Object> get props => [product];
}

class AddBundle extends CartEvent {
  final BundleCart bundle;

  const AddBundle(this.bundle);

  @override
  List<Object> get props => [bundle];
}

class RemoveBundle extends CartEvent {
  final BundleCart bundle;

  const RemoveBundle(this.bundle);

  @override
  List<Object> get props => [bundle];
}

class AddQuantityBundle extends CartEvent {
  final BundleCart bundle;
  final int quantity;
  const AddQuantityBundle(this.bundle, this.quantity);

  @override
  List<Object> get props => [bundle];
}

class RemoveQuantityBundle extends CartEvent {
  final BundleCart bundle;

  final int quantity;

  const RemoveQuantityBundle(this.bundle, this.quantity);

  @override
  List<Object> get props => [bundle];
}