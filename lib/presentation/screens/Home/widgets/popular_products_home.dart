import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/products/application/popular_products/popular_products_bloc.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/widgets/dot_list/custom_dots_list.dart';
import 'package:GoDeli/presentation/widgets/item/custom_item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PopularProductsHome extends StatefulWidget {
  const PopularProductsHome({super.key});

  @override
  State<PopularProductsHome> createState() => _PopularProductsHomeState();
}

class _PopularProductsHomeState extends State<PopularProductsHome> {
  late PageController _pageController;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.6,
      initialPage: 1,
    );

    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (_currentPage != page) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.textTheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;

    return BlocProvider(
      create: (_) => getIt<PopularProductsBloc>(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título y botón de "view all"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TranslationWidget(
                  message:'Popular',
                  toLanguage: language,
                  builder: (translated) => Text(
                      translated,
                      style: textStyles.displayLarge
                    ), 
                  ),
                GestureDetector(
                  onTap: () => context.push('/catalog'),
                  child: 
                  TranslationWidget(
                  message:'view all',
                  toLanguage: language,
                  builder: (translated) => Text(
                      translated,
                      textAlign: TextAlign.end,
                    style: textStyles.displaySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold),
                    ), 
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // BlocBuilder para productos populares
          BlocBuilder<PopularProductsBloc, PopularProductsState>(
            builder: (context, state) {
              if (state is PopularProductsError) {
                return Center(
                  child: Text(
                    'Something went wrong',
                    style: textStyles.bodyLarge?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              if (state is PopularProductsLoaded) {
                if (state.products.isEmpty) {
                  return Center(
                      child: Text(
                    'There are no products available',
                    style: textStyles.bodyLarge?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ));
                }
                return Column(
                  children: [
                    // PageView
                    SizedBox(
                      height: 400, // Ajusta la altura según tus necesidades
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: state.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          final currentProduct = state.products[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: CustomItemProduct(
                              current: currentProduct,
                              theme: theme,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Puntos indicadores
                    CustomDotsList(
                        currentPage: _currentPage,
                        theme: theme,
                        list: state.products),
                  ],
                );
              }
              // Lista de productos populares

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
