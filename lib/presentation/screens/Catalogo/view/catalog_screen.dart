import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/categories/application/catalog/catalog_bloc.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/catalog_body.dart';


class CatalogScreen extends StatelessWidget {
  final String category;

  const CatalogScreen({super.key, required this.category });
  static const String name = "catalog_page";

  @override
  Widget build(BuildContext context) {
    return CatalogScreenView(category: category);
  }
}

class CatalogScreenView extends StatelessWidget {
  final String category;
  
  const CatalogScreenView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final itemsCountCart =
        context.select((CartBloc bloc) => bloc.state.totalItems);

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
      body: BlocProvider<CatalogBloc>(
        create: (context) => getIt<CatalogBloc>()..add(CategorySet(category)),
        child: const CatalogBody(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/cart'),
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
