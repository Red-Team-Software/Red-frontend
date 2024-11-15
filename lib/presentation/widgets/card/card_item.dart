import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/cart/application/cart/cart_bloc.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.current,
  });

  final Bundle current;

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartBloc>();

    final theme = Theme.of(context);

    return GestureDetector(
        onTap: () {
          context.push('/bundle/${current.id}');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.00, vertical: 8.00),
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 300,
              width: 220,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: theme.brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    height: 110,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        current.imageUrl.isNotEmpty ? current.imageUrl[0] : '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            current.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Icon(Icons.fireplace),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      current.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ ${current.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        if (!cartBloc.isBundleInCart(
                            BundleCart(bundle: current, quantity: 1)))
                          IconButton.filled(
                            onPressed: () {
                              final bundleCart = BundleCart(
                                bundle: current,
                                quantity: 1,
                              );
                              cartBloc.add(AddBundle(bundleCart));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_box,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          '${current.name} added to cart!',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  duration: const Duration(seconds: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.fromLTRB(16, 0, 16, 36),
                                  elevation: 100,
                                ),
                              );
                            },
                            icon: Icon(Icons.add,
                                size: 16, weight: 16, color: Colors.white),
                            style: IconButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              padding: const EdgeInsets.all(2),
                              minimumSize: const Size(24, 24),
                            ),
                          )
                        else
                          IconButton.filled(
                            onPressed: null,
                            icon: const Icon(Icons.check,
                                size: 24, color: Colors.black),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(2),
                              minimumSize: const Size(24, 24),
                              shape: CircleBorder(
                                  side: BorderSide(
                                      color: Colors.black, width: 0.3)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
