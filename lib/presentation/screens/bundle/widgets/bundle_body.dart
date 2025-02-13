import 'package:GoDeli/features/bundles/application/bundle_details/bundle_details_bloc.dart';
import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BundleBody extends StatelessWidget {
  final ThemeData theme;
  final String idBundle;
  const BundleBody({super.key, required this.theme, required this.idBundle});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<BundleDetailsBloc, BundleDetailsState>(
          builder: (context, state) {
            final Bundle newBundle = Bundle(
              id: idBundle,
              name: state.bundle.name,
              description: state.bundle.description,
              price: state.bundle.price,
              imageUrl: state.bundle.imageUrl,
              currency: state.bundle.currency,
              categories: state.bundle.categories,
              promotions: state.bundle.promotions,
              products: state.bundle.products,
              expirationDate: state.bundle.expirationDate,
              inStock: state.bundle.inStock,
              measurement: state.bundle.measurement,
              weight: state.bundle.weight,
            );
            switch (state.status) {
              case BundleDetailsStatus.loading:
              case BundleDetailsStatus.initial:
                return const Center(child: CircularProgressIndicator());

              case BundleDetailsStatus.error:
                return const Center(
                  child: Text(
                    'Ups! Something went wrong',
                    style: TextStyle(color: Colors.red),
                  ),
                );

              case BundleDetailsStatus.loaded:
                return DetailsView(
                    images: newBundle.imageUrl,
                    name: newBundle.name,
                    description: newBundle.description,
                    price: newBundle.price,
                    currency: newBundle.currency,
                    promotions: newBundle.promotions,
                    categories: newBundle.categories,
                    bundleProducts: newBundle.products,
                    expirationDate: newBundle.expirationDate,
                    buttonWidget: buttonWidget(context, newBundle));
            }
          },
        ),
      ),
    );
  }

  Widget buttonWidget(BuildContext context, Bundle bundle) {
    final cartBloc = context.watch<CartBloc>();
    final textStyles = Theme.of(context).textTheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;

    return Flex(
      direction: Axis.vertical,
      children: [
        if (!cartBloc.isBundleInCart(BundleCart(bundle: bundle, quantity: 1)))
          ElevatedButton(
            onPressed: () => _showModal(context, theme, bundle),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24),
            ),
            child: Center(
              child: TranslationWidget(
                message:'Add to Cart',
                toLanguage: language,
                builder: (translated) => Text(
                    translated,
                    style: textStyles.displaySmall?.copyWith(
                      color: Colors.white,
                    )
                ), 
              ),
            ),
          ),
        if (cartBloc.isBundleInCart(BundleCart(bundle: bundle, quantity: 1)))
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
                message:'Already in Cart',
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
          )
      ],
    );
  }

  Future<dynamic> _showModal(
      BuildContext context, ThemeData theme, Bundle bundle) {
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
                        'Price: ${bundle.price * quantity} ${bundle.currency}',
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
                      final bundleCart =
                          BundleCart(bundle: bundle, quantity: quantity);
                      context.read<CartBloc>().add(AddBundle(bundleCart));
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
