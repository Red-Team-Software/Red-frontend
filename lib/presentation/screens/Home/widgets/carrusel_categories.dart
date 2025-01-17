import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';

class CategoriesCarrusel extends StatelessWidget {
  const CategoriesCarrusel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.textTheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;

    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Botón "view all"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [ TranslationWidget(
                  message:'Categories',
                  toLanguage: language,
                  builder: (translated) => Text(
                      translated,
                      style: textStyles.displayLarge
                  ), 
                ),
                GestureDetector(
                  onTap: () => context.push('/catalog'),
                  child: TranslationWidget(
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
          const SizedBox(height: 8),
          // BlocBuilder para categorías
          SizedBox(
            height: 300,
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state.status == CategoriesStatus.loading &&
                    state.categories.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.categories.isEmpty &&
                    (state.status == CategoriesStatus.allLoaded ||
                        state.status == CategoriesStatus.loaded)) {
                  return Center(
                    child: Text(
                      'Algo raro pasó, no hay categorías!',
                      style: textStyles.bodyLarge?.copyWith(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }

                if (state.status == CategoriesStatus.error) {
                  return Center(
                    child: Text(
                      'Algo inesperado pasó',
                      style: textStyles.bodyLarge?.copyWith(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }

                if (state.status != CategoriesStatus.loading &&
                    state.categories.isEmpty) {
                  return Center(
                      child: Text('No hay categorías',
                          style: textStyles.bodyLarge?.copyWith(
                              color: theme.colorScheme.error,
                              fontWeight: FontWeight.bold)));
                }

                // Carrusel de categorías
                return SizedBox(
                  height: 250,
                  child: SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal, // Desplazamiento horizontal
                    child: Row(
                      children: List.generate(state.categories.length, (index) {
                        final currentCategory = state.categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0), // Espaciado entre elementos
                          child: SizedBox(
                            width: 150, // Ancho de cada elemento
                            child: CustomCategoryHome(
                              current: currentCategory,
                              textStyles: textStyles,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCategoryHome extends StatelessWidget {
  const CustomCategoryHome({
    super.key,
    required this.current,
    required this.textStyles,
  });

  final Category current;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final language =  context.watch<LanguagesCubit>().state.selected.language;
    
    return SizedBox(
      height: 250,
      width: 150,
      child: GestureDetector(
          onTap: () {
            context.push('/catalog/${current.name}');
          },
          child: Card(
              elevation: 6,
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: current.icon!.isNotEmpty
                            ? Image.network(
                                current.icon!,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.image_not_supported,
                                size: 64,
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.6)),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        right: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslationWidget(
                                message: current.name,
                                toLanguage: language,
                                builder: (translatedMessage) => Text(
                                      translatedMessage,
                                      style: textStyles.displaySmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    )),

                            const SizedBox(height: 4),

                            // Descripción del producto
                            TranslationWidget(
                                message: 'More Details',
                                toLanguage: language,
                                builder: (translatedMessage) => Text(
                                      translatedMessage,
                                      style: textStyles.bodySmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                          ],
                        ),
                      ),
                    ],
                  )))
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(
          //         vertical: 8.0, horizontal: 16.0),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         ClipRRect(
          //           borderRadius: BorderRadius.circular(8),
          //           child: Image.network(
          //             currentCategory.icon!,
          //             height: 80, // Tamaño de la imagen
          //             width: 80,
          //             fit: BoxFit.cover,
          //             errorBuilder: (context, error, stackTrace) {
          //               return Container(
          //                 height: 80,
          //                 width: 80,
          //                 color: Colors.grey,
          //                 child: const Icon(
          //                   Icons.image_not_supported,
          //                   color: Colors.white,
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //         const SizedBox(width: 16),
          //        Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             // Título
          //             TranslationWidget(
          //               message: currentCategory.name,
          //               toLanguage: context
          //                   .read<LanguagesCubit>()
          //                   .state
          //                   .selected
          //                   .language,
          //               builder: (translatedMessage) => Text(
          //                 translatedMessage,
          //                 style: textStyles.bodyLarge?.copyWith(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 16,
          //                 ),
          //                 maxLines: 1,
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //             ),
          //             const SizedBox(height: 4),

          //             // Subtítulo o descripción
          //             Text(
          //               "More details", // Puedes cambiar esto por una descripción de tu categoría
          //               style: textStyles.bodySmall?.copyWith(
          //                 color: Colors.grey,
          //               ),
          //               maxLines: 1,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // )
          ),
    );
  }
}
