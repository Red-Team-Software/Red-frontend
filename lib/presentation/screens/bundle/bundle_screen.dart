import 'package:GoDeli/features/bundles/application/bundle_details/bundle_details_bloc.dart';
import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/cart/application/cart/cart_bloc.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:GoDeli/config/injector/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BundleScreen extends StatelessWidget {
  static const String name = 'details_bundle_screen';

  final String idBundle;
  const BundleScreen({super.key, required this.idBundle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BundleDetailsBloc>()..getBundleById(idBundle),
      child: const _BundleView(),
    );
  }
}

class _BundleView extends StatelessWidget {
  const _BundleView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<BundleDetailsBloc, BundleDetailsState>(
          builder: (context, state) {
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
                return Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Stack(
                        children: [
                          Image.network(
                            state.bundle.imageUrl[0],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 300,
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black54,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black54,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buttonArrow(context),
                    _scrollableDetails(context, state.bundle, theme)
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  Widget _buttonArrow(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      child: Center(
        child: InkWell(
          onTap: () => context.pop(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _scrollableDetails(
      BuildContext context, Bundle bundle, ThemeData theme) {
    final cartBloc = context.watch<CartBloc>();

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.68,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bundle.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${bundle.price} ${bundle.currency} / piece',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Wrap(
                        spacing: 8,
                        // children: product.categories
                        // .map((category) => Chip(label: Text(category)))
                        // .toList(),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        bundle.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (!cartBloc
                  .isBundleInCart(BundleCart(bundle: bundle, quantity: 1)))
                ElevatedButton(
                  onPressed: () => _showModal(context, theme, bundle),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  child: const Center(
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (cartBloc
                  .isBundleInCart(BundleCart(bundle: bundle, quantity: 1)))
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
                  child: const Center(
                    child: Text(
                      'Already in Cart',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _showModal(
      BuildContext context, ThemeData theme, Bundle bundle) {
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
                    child: const Center(
                      child: Text(
                        'Confirm and Add to Cart',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
