part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent {
  const ProductDetailsEvent();

}

class ProductLoaded extends ProductDetailsEvent{
  final Product product;
  const ProductLoaded({required this.product});
}

class LoadingStarted extends ProductDetailsEvent{}

class ErrorOnProductLoading extends ProductDetailsEvent{}