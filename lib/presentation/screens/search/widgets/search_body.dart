import 'package:GoDeli/presentation/widgets/item/custom_item_product.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/Search/bloc/bloc.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 80.0,
          forceMaterialTransparency: true,
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 24.0),
            child: _InputSearch(),
          ),
        ),
    
        BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state.status == SearchStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('An error occurred'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == SearchStatus.loading) {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } 

            if (state.products.isEmpty && state.bundles.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text('No results found'),
                ),
              );
            }

            return SliverPadding(
                  padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return CustomItemProduct(current: state.products[index], theme: Theme.of(context));
                      },
                      childCount: state.products.length,
                    ),
                  ),
                );
          },
        ),
      ],
    );
  }
}

class _InputSearch extends StatelessWidget {

  final TextEditingController controller = TextEditingController();

  _InputSearch();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      onChanged: (text) => controller.text = text,
      hintText: 'Search for products or bundles',
      backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
      trailing: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => context.read<SearchBloc>().add(CustomSearchEvent(query: controller.text)),
        ),
      ],
    );
  }
}
