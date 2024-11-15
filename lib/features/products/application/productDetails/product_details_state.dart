part of 'product_details_bloc.dart';

enum ProductDetailsStatus { initial, loading, loaded, error }
class ProductDetailsState extends Equatable {

  final Product product;
  final ProductDetailsStatus status;

  const ProductDetailsState({
    required this.product,
    this.status = ProductDetailsStatus.initial,
  });

  ProductDetailsState copyWith({
    Product? product,
    ProductDetailsStatus? status,
  }) {
    return ProductDetailsState(
      product: product ?? this.product,
      status: status ?? this.status,
    );
  }
  
  @override
  List<Object> get props => [product, status];
}

