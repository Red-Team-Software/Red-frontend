import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/presentation/widgets/item/custom_item_product.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
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
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
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

            if (state.status == SearchStatus.initial) {
              return initialSearchBody(context);
            }

            if (state.products.isEmpty &&
                state.bundles.isEmpty &&
                state.status != SearchStatus.initial) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text('No results found'),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                    'Products',
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 2),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return CustomItemProduct(
                            current: state.products[index],
                            theme: Theme.of(context));
                      },
                    ),
                  ])
              ),
            );
          },
        ),
      ],
    );
  }

  SliverFillRemaining initialSearchBody(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.search, size: 64),
              const SizedBox(height: 16),
              const Text('Start searching for products and bundles'),
              const SizedBox(height: 16),
              const Text('Here some popular searches...'),
              const SizedBox(height: 8),
              const CardBundleCarrusel(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Products',
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                        'view all',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w700),
                      )),
                ],
              ),
              const SizedBox(height: 16),
              BlocBuilder<AllProductsBloc, AllProductsState>(
                builder: (context, state) {
                  if (state.status == ProductsStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.status == ProductsStatus.error) {
                    return const Center(
                      child: Text('An error occurred'),
                    );
                  }

                  if (state.products.isEmpty) {
                    return const Center(
                      child: Text('No products found'),
                    );
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 2),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return CustomItemProduct(
                          current: state.products[index],
                          theme: Theme.of(context));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputSearch extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  _InputSearch();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return SearchBar(
          onChanged: (text) => controller.text = text,
          hintText: 'Search for products or bundles',
          backgroundColor: WidgetStateProperty.all(Colors.grey[300]),
          trailing: [
            state.status != SearchStatus.initial
                ? IconButton(
                    icon: Icon(Icons.clear, color: Theme.of(context).primaryColor),
                    onPressed: () {
                      context.read<SearchBloc>().add(const ResetSearchEvent());
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      context.read<SearchBloc>().onSearch(controller.text);
                    },
                  )
          ],
        );
      },
    );
  }
}
