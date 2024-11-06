import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';

class CardBundleCarrusel extends StatelessWidget {
  const CardBundleCarrusel({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);    
    return SizedBox(
      height: 288,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Bundle Offers',
            style: TextStyle(
                color: theme.brightness==Brightness.dark?Colors.white:Colors.black, fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Expanded(child: BlocBuilder<AllProductsBloc, AllProductsState>(
              builder: (context, state) {
            if (state.status == ProductsStatus.loading &&
                state.products.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ProductsStatus.error) {
              return const Center(
                child: Text('Algo inesperado paso',
                    style: TextStyle(color: Colors.red)),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.products.length,
              itemBuilder: (BuildContext context, int index) {
                Product current = state.products[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 240,
                    height: 320,
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CardItem(current: current),
                  ),
                );
              },
            );
          }))
        ],
      ),
    );
  }
}