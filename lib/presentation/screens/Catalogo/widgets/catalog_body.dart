import 'dart:async';

import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';
import 'package:GoDeli/features/catalog/bloc/catalog_bloc.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/Catalogo/widgets/filter_modal.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/screens/skeleton/skeleton_screen.dart';
import 'package:GoDeli/presentation/widgets/item/custom_item_bundle.dart';
import 'package:GoDeli/presentation/widgets/item/custom_item_product.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CatalogBody extends StatefulWidget {
  const CatalogBody({super.key});

  @override
  State<CatalogBody> createState() => _CatalogBodyState();
}

class _CatalogBodyState extends State<CatalogBody> {
  bool showProducts = true;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // print(
    //     '_scrollController.position.pixels: ${_scrollController.position.pixels}\n _scrollController.position.maxScrollExtent: ${_scrollController.position.maxScrollExtent}');
    // if (_scrollController.position.pixels >=
    //         _scrollController.position.maxScrollExtent &&
    //     !isLoadingMore) {
    //   setState(() {
    //     isLoadingMore = true;
    //   });

    //   final catalogBloc = context.read<CatalogBloc>();

    //   // Incrementar la página y cargar más elementos
    //   final nextPage = catalogBloc.state.page + 1;
    //   catalogBloc.add(PageSet(nextPage));
    //   catalogBloc.add(const FetchItems(isPagination: true));

    //   Future.delayed(const Duration(seconds: 1), () {
    //     if (mounted) {
    //       setState(() {
    //         isLoadingMore = false;
    //       });
    //     }
    //   });
    // }
  }

  // Método para construir el contenido de Bundles
  Widget _buildBundles(BuildContext context) {
    final language = context.watch<LanguagesCubit>().state.selected.language;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        if (state.status == CatalogStatus.loading) {
          return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => const Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 18.0
                  ),
                  child: SkeletonWidget(  
                  ),
                ),
              );
        }
        if (state.status == CatalogStatus.error) {
          return Center(child: 
            TranslationWidget(
              message:'Error loading bundles',
              toLanguage: language,
              builder: (translated) => Text(
                translated
              ), 
            )
          );
        }
        if (state.bundles.isEmpty && state.status == CatalogStatus.loaded) {
          return Center(
              child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centrar verticalmente
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Centrar horizontalmente
                  children: [
                SvgPicture.asset(
                  'images/sad_face.svg',
                  height: 100,
                  color: colors.primary,
                ),
                const SizedBox(height: 16),
                Center(
                    child: TranslationWidget(
                  message: 'No bundles fullfill your request',
                  toLanguage: language,
                  builder: (translated) => Text(
                    translated,
                    textAlign: TextAlign.end,
                    style: textStyles.displaySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ]));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
            ),
            itemCount: state.bundles.length,
            itemBuilder: (context, index) {
              final item = state.bundles[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomItemBundle(current: item, theme: theme),
              );
            },
          ),
        );
      },
    );
  }

  // Método para construir el contenido de Products
  Widget _buildProducts(BuildContext context) {
    final language = context.watch<LanguagesCubit>().state.selected.language;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        // if (state.status == CatalogStatus.loading) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        if (state.status == CatalogStatus.error) {
          return Center(child: 
            TranslationWidget(
              message:'Error loading products',
              toLanguage: language,
              builder: (translated) => Text(
                translated,
                style: textStyles.displaySmall?.copyWith(
                color: colors.error,
              )
              ), 
            )
          );
        }
        if (state.products.isEmpty && state.status == CatalogStatus.loaded) {
          return Center(
              child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centrar verticalmente
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Centrar horizontalmente
                  children: [
                SvgPicture.asset(
                  'images/sad_face.svg',
                  height: 100,
                  color: colors.primary,
                ),
                const SizedBox(height: 16),
                Center(
                    child: TranslationWidget(
                  message: 'No products fullfill your request',
                  toLanguage: language,
                  builder: (translated) => Text(
                    translated,
                    textAlign: TextAlign.end,
                    style: textStyles.displaySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ]));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomItemProduct(current: product, theme: theme),
                    );
                  },
                ),
              ),
              if (isLoadingMore) const LinearProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = context.watch<LanguagesCubit>().state.selected.language;
    final categories =
        List<Category>.from(context.watch<CategoriesBloc>().state.categories);
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final catalogBloc = context.read<CatalogBloc>();


    return DefaultTabController(
      length: 2, // Dos pestañas: Bundles y Products
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverToBoxAdapter(
            child: InputSearch(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslationWidget(
                  message: 'Filters',
                  toLanguage: language,
                  builder: (translated) => Text(
                    translated,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                 
                  IconButton(
                    icon: Icon(Icons.filter_list, color: colors.primary),
                    onPressed: () async {
                      final appliedFilters =
                          await showModalBottomSheet<Map<String, dynamic>>(
                        context: context,
                        builder: (BuildContext context) {
                          return FilterModal(
                            categories: categories,
                            selectedCategories:
                                catalogBloc.state.categorySelected,
                            discount: catalogBloc.state.discount,
                            popular: catalogBloc.state.popular,
                            price: catalogBloc.state.price,
                            term: catalogBloc.state.term,
                          );
                        },
                      );

                      if (appliedFilters != null) {
                        if (appliedFilters['categories'] != null) {
                          catalogBloc.add(
                              CategoryListSet(appliedFilters['categories']));
                        }
                        if (appliedFilters['discount'] != null) {
                          catalogBloc
                              .add(DiscountSet(appliedFilters['discount']));
                        }
                        if (appliedFilters['popular'] != null) {
                          catalogBloc.add(
                              PopularSet(popular: appliedFilters['popular']));
                        }
                        if (appliedFilters['price'] != null) {
                          catalogBloc.add(PriceSet(appliedFilters['price']));
                        }
                        if (appliedFilters['term'] != null) {
                          catalogBloc.add(TermSet(appliedFilters['term']));
                        }
                        catalogBloc.add(const FetchItems());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            TabBar(
              indicator: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: colors.primary,
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center, 
                    child: TranslationWidget(
                      message:'Bundles',
                      toLanguage: language,
                      builder: (translated) => Text(
                          translated,
                          style: TextStyle(
                            fontSize: textStyle.displaySmall!.fontSize,
                            fontWeight: FontWeight.bold,
                          )
                      ), 
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: 
                    TranslationWidget(
                      message:'Products',
                      toLanguage: language,
                      builder: (translated) => Text(
                        translated,
                        style: TextStyle(
                          fontSize: textStyle.displaySmall!.fontSize,
                          fontWeight: FontWeight.bold,
                        )
                      ), 
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildBundles(context), // Contenido de Bundles
                  _buildProducts(context), // Contenido de Products
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputSearch extends StatefulWidget {
  const InputSearch({super.key});

  @override
  InputSearchState createState() => InputSearchState();
}

class InputSearchState extends State<InputSearch> {
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
      // Llamar al bloc para actualizar los datos
      final catalogBloc = context.read<CatalogBloc>();

      if (text.isNotEmpty) {
        catalogBloc.add(TermSet(text));
        catalogBloc.add(const FetchItems());
      } else {
        catalogBloc.add(const TermSet(''));
        catalogBloc.add(const FetchItems());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: TranslationWidget(
        message: 'Search for products or bundles',
        toLanguage: language,
        builder: (traduced) => TextField(
          controller: controller,
          onChanged: _onTextChanged,
          decoration: InputDecoration(
            hintText: traduced,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: colors.primary),
                    onPressed: () {
                      controller.clear();
                      _onTextChanged('');
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}


// class CategoriesSliverCatalog extends StatelessWidget {
//   const CategoriesSliverCatalog({
//     super.key,
//     required this.categories,
//   });

//   final List<Category> categories;

//   @override
//   Widget build(BuildContext context) {
//     final textStyle = Theme.of(context).textTheme;
//     return SliverPersistentHeader(
//       pinned: true,
//       delegate: _SliverAppBarDelegate(
//         minHeight: 80.0,
//         maxHeight: 90.0,
//         child: Container(
//           padding: const EdgeInsets.all(8.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8.0),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//               child: Container(
//                 color: Colors.white.withOpacity(0.5),
//                 child: ListView.separated(
//                   separatorBuilder: (context, index) =>
//                       const SizedBox(width: 8),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: categories.length,
//                   itemBuilder: (context, index) {
//                     final category = categories[index];
//                     return ChoiceChip(
//                       showCheckmark: false,
//                       selectedColor: Theme.of(context).primaryColor,
//                       disabledColor: Colors.grey[200],
//                       selected: context
//                           .watch<CatalogBloc>()
//                           .state
//                           .categorySelected
//                           .any((element) => element == category.name),
//                       onSelected: (selected) {
//                         context
//                             .read<CatalogBloc>()
//                             .add(CategorySet(category.name));
//                       },
//                       label: TranslationWidget(
//                         message: category.name,
//                         toLanguage: context
//                             .watch<LanguagesCubit>()
//                             .state
//                             .selected
//                             .language,
//                         builder: (translated) => Text(translated),
//                       ),
//                       elevation: 5.0,
//                       labelStyle: textStyle.bodyLarge?.copyWith(
//                         color: context
//                                 .watch<CatalogBloc>()
//                                 .state
//                                 .categorySelected
//                                 .any((element) => element == category.name)
//                             ? Colors.white
//                             : Theme.of(context).primaryColor,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });

//   final double minHeight;
//   final double maxHeight;
//   final Widget child;

//   @override
//   double get minExtent => minHeight;
//   @override
//   double get maxExtent => maxHeight;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight ||
//         minHeight != oldDelegate.minHeight ||
//         child != oldDelegate.child;
//   }
// }
