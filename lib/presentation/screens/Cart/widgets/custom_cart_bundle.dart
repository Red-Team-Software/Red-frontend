import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BundleWidget extends StatelessWidget {
  final BundleCart bundle;
  const BundleWidget({super.key, required this.bundle});

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartBloc>();

    final colors = Theme.of(context).colorScheme;

    return Slidable(
      endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                cartBloc.add(RemoveBundle(bundle));
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            )
          ]),
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Imagen del producto (puede ser un icono o una imagen de red)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: bundle.bundle.imageUrl.isNotEmpty
                  ? Image.network(
                      bundle.bundle.imageUrl[0],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 30,
                          ),
                        );
                      },
                    )
                  : Icon(Icons.image_not_supported,
                      size: 60, color: colors.onSurface.withOpacity(0.6)),
            ),
            const SizedBox(width: 8), // Espacio entre la imagen y el texto
            // Información del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bundle.bundle.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                      width: 8), // Espacio entre la imagen y el texto
                  Text(
                    bundle.bundle.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '\$${bundle.bundle.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                    width:
                        16), // Espacio entre el precio y el control de cantidad
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
                          product: bundle,
                          icon: Icons.remove_circle,
                          color: colors.primary,
                          onPressed: () {
                            cartBloc.add(RemoveQuantityBundle(bundle, 1));
                          }),
                      Text(
                        '${bundle.quantity}', // Aquí muestra la cantidad actual
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QuantityButton(
                          isMinus: false,
                          product: bundle,
                          icon: Icons.add_circle,
                          color: colors.primary,
                          onPressed: () {
                            cartBloc.add(AddQuantityBundle(bundle, 1));
                          }),
                    ],
                  ),
                )
              ],
            )
            // Precio
            ,
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
  final BundleCart product;
  final IconData icon;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (product.quantity == 1 && isMinus) {
      return IconButton(
          icon: Icon(icon, color: Colors.grey, size: 20), onPressed: null);
    }

    return IconButton(
        icon: Icon(icon, color: Colors.red, size: 20), onPressed: onPressed);
  }
}
