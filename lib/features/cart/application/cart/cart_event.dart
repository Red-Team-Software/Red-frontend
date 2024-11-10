part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ClearCart extends CartEvent {}

class AddProduct extends CartEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProduct extends CartEvent {
  final Product product;

  const RemoveProduct(this.product);

  @override
  List<Object> get props => [product];
}

class AddOneQuantityProduct extends CartEvent {
  final Product product;

  const AddOneQuantityProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveOneQuantityProduct extends CartEvent {
  final Product product;

  const RemoveOneQuantityProduct(this.product);

  @override
  List<Object> get props => [product];
}