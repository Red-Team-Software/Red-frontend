import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomItemBundle extends StatelessWidget {
  const CustomItemBundle({
    super.key,
    required this.current,
    required this.theme,
  });

  final Bundle current;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartBloc>();
    final textStyle = theme.textTheme;
    final language = context.watch<LanguagesCubit>().state.selected.language;

    return GestureDetector(
      onTap: () {
        context.push('/bundle/${current.id}');
      },
      child: Card(
        elevation: 6,
        color: theme.brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Imagen de fondo
              SizedBox(
                width: double.infinity,
                height: 400,
                child: current.imageUrl.isNotEmpty
                    ? Image.network(
                        current.imageUrl[0],
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.image_not_supported,
                        size: 64,
                        color: theme.colorScheme.onSurface.withOpacity(0.6)),
              ),

              // Gradiente oscuro en la parte inferior
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

              // Contenido superpuesto
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TranslationWidget(
                      message: current.name,
                      toLanguage: language,
                      builder:(translatedMessage) => Text(
                      translatedMessage,
                      style: textStyle.displaySmall?.copyWith(
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    )),
                    
                    const SizedBox(height: 4),

                    // Descripción del producto
                    TranslationWidget(
                      message: current.description,
                      toLanguage: language,
                      builder:(translatedMessage) => Text(
                      translatedMessage,
                      style: textStyle.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                    
                    const SizedBox(height: 8),

                    // Precio y botón de acción
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Precio
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '\$${current.price}',
                            style: textStyle.displaySmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Botón agregar/quitar del carrito
                        if (!cartBloc.isBundleInCart(
                            BundleCart(bundle: current, quantity: 1)))
                          IconButton(
                            onPressed: () {
                              BundleCart bundleCart = BundleCart(
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
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              padding: const EdgeInsets.all(8),
                              minimumSize: const Size(40, 40),
                            ),
                          )
                        else
                          IconButton(
                            onPressed: null,
                            icon: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(8),
                              minimumSize: const Size(40, 40),
                              shape: const CircleBorder(),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
