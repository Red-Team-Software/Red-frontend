import 'package:GoDeli/features/cart/application/cart/cart_bloc.dart';
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
      onTap: (){
        context.push('/product/${current.id}');
      },
      child: Card(
        elevation: 4,
        color: theme.brightness==Brightness.dark?  Colors.grey[800]: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(8.00),
                child: Image.network(
                  current.imageUrl.isNotEmpty ? current.imageUrl[0] : '',
                  fit: BoxFit.cover,
                ),),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(current.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.brightness==Brightness.dark?Colors.white:Colors.black54),),
                    Text(current.description, maxLines: 1, overflow: TextOverflow.clip,),
                  ],
                ),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('\$${current.price}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4.00),
                  IconButton.filled(
                    onPressed: () {
                      ProductCart productCart = ProductCart(
                        product: current,
                        quantity: 1,
                      );

                      cartBloc.add(AddProduct(productCart));

                    },
                    icon: const Icon(Icons.add, size: 24, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.all(0.5),
                      minimumSize: const Size(24, 24),
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
