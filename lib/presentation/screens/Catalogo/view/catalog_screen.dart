import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/catalog_body.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});
  static const String name = "catalog_page";

  @override
  Widget build(BuildContext context) {
    return const CatalogScreenView();
  }
}

class CatalogScreenView extends StatelessWidget {
  const CatalogScreenView({super.key});

  @override
  Widget build(BuildContext context) {

    final itemsCountCart = context.select((CartBloc bloc) => bloc.state.totalItems);
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top Deals'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CatalogSearchDelegate(),
                );
              },
            )
          ],
        ),
        
        body: const CatalogBody(),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: ()=> context.push('/cart'),
          isExtended: true,
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.00),
            child: Row(
              children: [
                const Icon(Icons.shopping_cart),
                const SizedBox(width: 8.0),
                Text('$itemsCountCart items in cart'),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
  }
}


class CatalogSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search result for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Suggestions for "$query"'),
    );
  }
}