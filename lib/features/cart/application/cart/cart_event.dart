part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

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

class AddOneQuantityProduct extends CartEvent {
  final ProductCart product;

  const AddOneQuantityProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveOneQuantityProduct extends CartEvent {
  final ProductCart product;

  const RemoveOneQuantityProduct(this.product);

  @override
  List<Object> get props => [product];
}