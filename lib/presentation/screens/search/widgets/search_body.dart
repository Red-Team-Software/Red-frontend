import 'dart:async';

import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 88.0,
          automaticallyImplyLeading: false,
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
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off_outlined, size: 64),
                    SizedBox(height: 16),
                    Text('Nothing found'),
                  ],
                )),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.00),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    if (state.bundles.isNotEmpty) ...[
                      Text(
                        'Bundles',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 260,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.bundles.length,
                          itemBuilder: (BuildContext context, int index) {
                            Bundle current = state.bundles[index];
                            return GestureDetector(
                              onTap: () {},
                              child: BundleHomeCard(current: current),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                                width: 24); // Espacio entre los elementos
                          },
                        ),
                      )
                    ],
                    if (state.products.isNotEmpty) ...[
                      Text(
                        'Products',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
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
                            theme: Theme.of(context),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  SliverFillRemaining initialSearchBody(BuildContext context) {
    return const SliverFillRemaining(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.search, size: 64),
              SizedBox(height: 16),
              Text('Start searching for products and bundles'),
              SizedBox(height: 16),
              Text('Here some popular searches...'),
              SizedBox(height: 8),
              // CardBundleCarrusel(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputSearch extends StatefulWidget {
  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<_InputSearch> {
  final TextEditingController controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel(); // Cancelar el temporizador al destruir el widget
    controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String text) {
    // Reiniciar el temporizador en cada cambio
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 700), () {
      // Llamar a la búsqueda automática después del tiempo de espera
      if (text.isNotEmpty) {
        context.read<SearchBloc>().onSearch(text);
      } else {
        context.read<SearchBloc>().add(const ResetSearchEvent());
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return SearchBar(
          controller: controller,
          onChanged: (text) {
            _onTextChanged(text);
          },
          hintText: 'Search for products or bundles',
          backgroundColor: WidgetStateProperty.all(Colors.grey[300]),
          trailing: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.status == SearchStatus.loading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : controller.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            controller.clear();
                            _onTextChanged('');
                            context
                                .read<SearchBloc>()
                                .add(const ResetSearchEvent());
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            context
                                .read<SearchBloc>()
                                .onSearch(controller.text);
                          },
                        ),
            ),
          ],
        );
      },
    );
  }
}
