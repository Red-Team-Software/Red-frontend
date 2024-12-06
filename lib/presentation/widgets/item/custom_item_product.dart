import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomItemProduct extends StatelessWidget {
  const CustomItemProduct({
    super.key,
    required this.current,
    required this.theme,
  });

  final Product current;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartBloc>();

    return GestureDetector(
      onTap: () {
        context.push('/product/${current.id}');
      },
      child: Card(
        elevation: 4,
        color: theme.brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: current.imageUrl.isNotEmpty
                      ? Image.network(
                          current.imageUrl[0],
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.image_not_supported,
                          size: 64,
                          color: theme.colorScheme.onSurface.withOpacity(0.6)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      current.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: theme.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black54),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      current.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('\$${current.price}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4.00),
                  if(!cartBloc.isProductInCart(ProductCart(product: current, quantity: 1)))
                  IconButton.filled(
                    onPressed: () {
                      ProductCart productCart = ProductCart(
                        product: current,
                        quantity: 1,
                      );
    
                      cartBloc.add(AddProduct(productCart));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.check_box, color: Colors.green,),
                                const SizedBox(width: 8),
                                Text('${current.name} added to cart!',),
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
                    icon: const Icon(Icons.add, size: 24, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.all(2),
                      minimumSize: const Size(24, 24),
                    ),
                  ) else 
                  GestureDetector(
                    onTap: (){},
                    child: IconButton.filled(
                      onPressed: null,
                      icon: const Icon(Icons.check, size: 24, color: Colors.black),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(2),
                        minimumSize: const Size(24, 24),
                        shape: const CircleBorder(side: BorderSide(color: Colors.black, width: 0.3)),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
