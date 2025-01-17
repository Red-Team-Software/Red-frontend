import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BundleHomeCard extends StatelessWidget {
  const BundleHomeCard({
    super.key,
    required this.current,
  });

  final Bundle current;

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartBloc>();
    final theme = Theme.of(context);
    final textStyle = theme.textTheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;

    return GestureDetector(
      onTap: () {
        context.push('/bundle/${current.id}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Stack(children: [
                      current.imageUrl.isNotEmpty
                          ? Image.network(
                              current.imageUrl[0],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                );
                              },
                            )
                          : const Icon(Icons.image_not_supported,
                              color: Colors.grey),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: current.promotions.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: 
                            TranslationWidget(
                              message:'Offer of the day!',
                              toLanguage: language,
                                builder: (translated) => Text(
                                  translated,
                                  style: textStyle.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )
                                ), 
                            ),
                          )
                        : const SizedBox(),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: !cartBloc.isBundleInCart(
                            BundleCart(bundle: current, quantity: 1))
                        ? IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              final bundleCart = BundleCart(
                                bundle: current,
                                quantity: 1,
                              );
                              cartBloc.add(AddBundle(bundleCart));
                              CustomSnackBar.show(
                                context,
                                type: SnackBarType.success,
                                title: 'Success',
                                message: '${current.name} added to cart!',
                              );
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              padding: const EdgeInsets.all(8),
                              minimumSize: const Size(40, 40),
                            ),
                          )
                        : IconButton(
                            onPressed: null,
                            icon: const Icon(
                              Icons.check_circle_outline_sharp,
                              color: Colors.green,
                              size: 40,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(8),
                              minimumSize: const Size(40, 40),
                              shape: const CircleBorder(),
                            ),
                          ),
                  ),
                ],
              ),

              // Título del producto
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TranslationWidget(
                message:current.name,
                toLanguage: language,
                builder: (translated) => Text(
                  translated,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle.displaySmall,
                ), 
              ),
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: 
                TranslationWidget(
                  message:current.description,
                  toLanguage: language,
                  builder: (translated) => Text(
                      translated,
                      style: textStyle.bodyLarge?.copyWith(// color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                  ), 
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Precios y descuento
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Descuento
                if (current.promotions.isNotEmpty &&
                    current.promotions[0].discount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${(current.promotions[0].discount * 100).floor()}%',
                        style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(width: 16),
                Row(children: [
                  if (current.promotions.isNotEmpty &&
                      current.promotions[0].discount > 0)
                    Text(
                      '\$${current.price}',
                        style: theme.textTheme.displaySmall?.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(width: 8),
                  // Precio final
                  Text(
                      '\$${(current.promotions.isNotEmpty ? current.price * (1 - current.promotions[0].discount) : current.price).toStringAsFixed(2)}',
                      style: theme.textTheme.displayMedium),
                ]),
                // Precios
                // Precio original (tachado si hay descuento)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
