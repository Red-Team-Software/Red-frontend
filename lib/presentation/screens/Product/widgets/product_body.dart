import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/products/application/productDetails/product_details_bloc.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/widgets/snackbar/custom_snackbar.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBody extends StatelessWidget {
  
  final String idProduct;
  const ProductBody({super.key, required this.idProduct});

  @override
  Widget build(BuildContext context) {
  final language =  context.watch<LanguagesCubit>().state.selected.language;

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
          listener: (context, state) {
            if (state.status == ProductDetailsStatus.error) {
              CustomSnackBar.show(
                context,
                title: 'Error',
                message: 'Ups! Something went wrong',
                type: SnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            final Product newProduct = Product(
              id: idProduct,
              name: state.product.name,
              description: state.product.description,
              price: state.product.price,
              imageUrl: state.product.imageUrl,
              currency: state.product.currency,
              categories: state.product.categories,
            );
            switch (state.status) {
              case ProductDetailsStatus.loading:
              case ProductDetailsStatus.initial:
                return const Center(child: CircularProgressIndicator());

              case ProductDetailsStatus.error:
                return Center(
                  child: 
                  TranslationWidget(
                    message:'Ups! Something went wrong',
                    toLanguage: language,
                    builder: (translated) => Text(
                      translated,
                      style: const TextStyle(color: Colors.red)
                    ), 
                  ),
                );

              case ProductDetailsStatus.loaded:
                return DetailsView(
                    images: newProduct.imageUrl,
                    name: newProduct.name,
                    description: newProduct.description,
                    price: newProduct.price,
                    currency: newProduct.currency ?? 'usd',
                    categories: newProduct.categories,
                    buttonWidget: buttonWidget(context, newProduct));
            }
          },
        ),
      ),
    );
  }

  Widget buttonWidget(BuildContext context, Product product) {
    final language =  context.watch<LanguagesCubit>().state.selected.language;
    final cartBloc = context.watch<CartBloc>();
    return Flex(
      direction: Axis.vertical,
      children: [
        if (!cartBloc.isProductInCart(ProductCart(product: product, quantity: 1)))
          ElevatedButton(
            onPressed: () => _showModal(context, Theme.of(context), product),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24),
            ),
            child: Center(
              child: 
              TranslationWidget(
                  message:'Add to Cart',
                  toLanguage: language,
                  builder: (translated) => Text(
                      translated,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )
                  ), 
                ),
            ),
          ),
        if (cartBloc
            .isProductInCart(ProductCart(product: product, quantity: 1)))
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 3,
              ),
            ),
            child: Center(
              child: 
              TranslationWidget(
                  message:'Add to Cart',
                  toLanguage: language,
                  builder: (translated) => Text(
                      translated,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )
                  ), 
              ),
            ),
          ),
      ],
    );
  }

  Future<dynamic> _showModal(
      BuildContext context, ThemeData theme, Product product) {
        final language =  context.watch<LanguagesCubit>().state.selected.language;
    int quantity = 1;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price: ${product.price * quantity} ${product.currency}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.remove, color: Colors.white),
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                setState(() => quantity++);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final prodCart =
                          ProductCart(product: product, quantity: quantity);
                      context.read<CartBloc>().add(AddProduct(prodCart));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Center(
                      child: TranslationWidget(
                        message:'Confirm and Add to Cart',
                        toLanguage: language,
                        builder: (translated) => Text(
                            translated,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )
                        ), 
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
