import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/catalog/bloc/catalog_bloc.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/catalog_body.dart';

class CatalogScreen extends StatelessWidget {
  final String? category;

  const CatalogScreen({super.key, this.category});
  static const String name = "catalog_page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final catalogBloc = getIt<CatalogBloc>();

        if (category != null && category!.isNotEmpty && category != '') {
          catalogBloc.add(CategorySet(category!));
        } else {
          catalogBloc.add( const PopularSet( popular: true ) );
        }
        return catalogBloc;
      },
      child: const CatalogScreenView(),
    );
  }
}

class CatalogScreenView extends StatelessWidget {

  const CatalogScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    
    final textStyle = Theme.of(context).textTheme;

    final itemsCountCart =
        context.select((CartBloc bloc) => bloc.state.totalItems);

    return Scaffold(
      appBar: AppBar(
        title:  Text('Catalog',
        style: textStyle.displayLarge,
        ),
        
      ),
      body: const CatalogBody(),

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => context.push('/cart'),
      //   isExtended: true,
      //   label: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16.00, vertical: 8.0),
      //     child: Row(
      //       children: [
      //         const Icon(Icons.shopping_cart),
      //         const SizedBox(width: 8.0),
      //         Text('$itemsCountCart items in cart', style: textStyle.displaySmall!.copyWith(color: Colors.white)
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
