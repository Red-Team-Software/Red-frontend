import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductWidget extends StatelessWidget {
  final ProductCart product;
  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartBloc>();

    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;

    return Slidable(
      endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            TranslationWidget(
              message: 'Delete',
              toLanguage: language,
              builder: (translated) => SlidableAction(
                onPressed: (context) {
                  cartBloc.add(RemoveProduct(product));
                },
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: translated,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            )
          ]),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: product.product.imageUrl.isNotEmpty
                  ? Image.network(
                      product.product.imageUrl[0],
                      width: 90,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90,
                          height: 120,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 30,
                          ),
                        );
                      },
                    )
                  : Icon(Icons.image_not_supported,
                      size: 90, color: colors.onSurface.withOpacity(0.6)),
            ),
            const SizedBox(width: 8), // Espacio entre la imagen y el texto
            // Información del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TranslationWidget(
                    message: product.product.name,
                    toLanguage: language,
                    builder: (translated) => Text(
                        translated,
                        style: textStyles.displayMedium
                    ), 
                  ),
                  const SizedBox(
                      width: 8), // Espacio entre la imagen y el texto
                  TranslationWidget(
                    message: product.product.description,
                    toLanguage: language,
                    builder: (translated) => Text(
                      translated,
                      style: textStyles.bodyMedium?.copyWith(
                        color: Colors.grey[700]
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                    ), 
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '\$${product.product.price}',
                          style: textStyles.displayMedium,
                        ),
                      ),
                      const SizedBox(width:16), // Espacio entre el precio y el control de cantidad
                      // Control de cantidad
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        height: 35,
                        child: Row(
                          children: [
                            QuantityButton(
                                isMinus: true,
                                product: product,
                                icon: Icons.remove_rounded,
                                color: colors.primary,
                                onPressed: () {
                                  cartBloc
                                      .add(RemoveQuantityProduct(product, 1));
                                }),
                            Text(
                              '${product.quantity}', // Aquí muestra la cantidad actual
                              style: textStyles.displaySmall,
                            ),
                            QuantityButton(
                                isMinus: false,
                                product: product,
                                icon: Icons.add_rounded,
                                color: colors.primary,
                                onPressed: () {
                                  cartBloc.add(AddQuantityProduct(product, 1));
                                }),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            // Precio
          ],
        ),
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  const QuantityButton(
      {super.key,
      required this.product,
      required this.icon,
      required this.onPressed,
      required this.color,
      required this.isMinus});

  final bool isMinus;
  final ProductCart product;
  final IconData icon;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    if (product.quantity == 1 && isMinus) {
      return IconButton(
          icon: Icon(icon, color: Colors.grey, size: 20), onPressed: null);
    }

    return IconButton(
        icon: Icon(icon, color: colors.primary, size: 20), onPressed: onPressed);
  }
}
