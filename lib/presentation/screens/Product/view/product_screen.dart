import 'package:GoDeli/presentation/screens/Product/widgets/product_body.dart';
import 'package:GoDeli/config/injector/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/products/application/productDetails/product_details_bloc.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const String name = 'details_product_screen';

  final String idProduct;
  const ProductScreen({super.key, required this.idProduct});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductDetailsBloc>()..getProductById(idProduct),
      child: _ProductView(idProduct: idProduct),
    );
  }
}

class _ProductView extends StatelessWidget {
  final String idProduct;
  const _ProductView({required this.idProduct});

  @override
  Widget build(BuildContext context) {

    return ProductBody(idProduct: idProduct);
    }
}
